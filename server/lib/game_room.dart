import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:shared/shared.dart';
import 'package:stream_channel/stream_channel.dart';

/// Manages a single game session, including state and player connections.
class GameRoom {
  /// Creates a new GameRoom with the given [id].
  GameRoom(this.id) : _state = GameState(id: id, players: []);

  /// The unique identifier for this game room.
  final String id;

  GameState _state;
  final Map<String, StreamChannel<dynamic>> _clients = {};
  Deck _currentDeck = Deck.standard();
  final _logger = Logger('GameRoom');

  /// The current state of the game.
  GameState get state => _state;

  /// Adds a client connection for the player with [id].
  void addClient(String id, StreamChannel<dynamic> channel) {
    _clients[id] = channel;

    // If player re-joining or new?
    // For now, assume new session = new player connection,
    // but check if ID matches existing player?
    // If ID is not in state, add them.
    if (!_state.players.any((p) => p.id == id)) {
      // Cannot join if game started
      if (_state.phase != GamePhase.waiting) {
        channel.sink.add(jsonEncode({'error': 'Game already started'}));
        channel.sink.close();
        return;
      }

      final newPlayer =
          Player(id: id, name: 'Player ${_state.players.length + 1}');
      _state = _state.copyWith(players: [..._state.players, newPlayer]);
    }

    _broadcast();
  }

  /// Removes the client connection for the player with [id].
  void removeClient(String id) {
    _clients.remove(id);
    // Don't remove player from state immediately to allow reconnect?
    // For now, if waiting, remove them. If playing, keep them (ghost).
    if (_state.phase == GamePhase.waiting) {
      final newPlayers = _state.players.where((p) => p.id != id).toList();
      _state = _state.copyWith(players: newPlayers);
      _broadcast();
    }
  }

  /// Handles an incoming message from a player.
  void handleMessage(String playerId, ClientMessage message) {
    if (message is JoinMessage) {
      final pIndex = _state.players.indexWhere((p) => p.id == playerId);
      if (pIndex != -1) {
        final updated = _state.players[pIndex]
            .copyWith(name: message.playerName, isReady: true);
        final newPlayers = List<Player>.from(_state.players)
          ..[pIndex] = updated;
        _state = _state.copyWith(players: newPlayers);
        _broadcast();
      }
    } else if (message is StartMessage) {
      if (_state.players.length >= 2 && _state.phase == GamePhase.waiting) {
        _startGame();
      }
    } else if (message is BidMessage) {
      _handleBid(playerId, message.amount);
    } else if (message is PlayMessage) {
      _handlePlay(playerId, message.card);
    }
  }

  void _startGame() {
    _state = _state.copyWith(
      phase: GamePhase.bidding,
      roundNumber: 1,
      cardsInRound: 1,
      currentPlayerIndex: 0,
      dealerIndex: 0,
    );
    _startRound();
  }

  void _startRound() {
    // 1. Shuffle
    _currentDeck = Deck.standard().shuffled();

    // 2. Deal
    final playersWithHands = <Player>[];
    for (final player in _state.players) {
      final draw = _currentDeck.draw(_state.cardsInRound);
      _currentDeck = draw.remaining;
      playersWithHands.add(
        player.copyWith(
          hand: draw.drawn
            ..sort(
              (a, b) => a.rank.value.compareTo(b.rank.value),
            ), // Sort for UX
          bid: null,
          tricksWon: 0,
        ),
      );
    }

    // 3. Set Trump (if deck has cards, flip one; else no trump?
    // Or different rule?)
    PlayingCard? trump;
    if (_currentDeck.cards.isNotEmpty) {
      final draw = _currentDeck.draw(1);
      trump = draw.drawn.first;
      // Remainder ignored
    } else {
      // No trump means NO trump suit.
      trump = null;
    }

    // 4. Update State
    // Dealer rotates? Yes.
    // Starter is Left of Dealer.
    final starterIndex = (_state.dealerIndex + 1) % _state.players.length;

    _state = _state.copyWith(
      phase: GamePhase.bidding,
      players: playersWithHands,
      trumpCard: trump,
      currentTrick: null,
      currentPlayerIndex: starterIndex,
      // Note: In bidding phase, we start with starterIndex.
    );
    _broadcast();
  }

  void _handleBid(String playerId, int amount) {
    if (_state.phase != GamePhase.bidding) return;

    final pIndex = _state.players.indexWhere((p) => p.id == playerId);
    if (pIndex != _state.currentPlayerIndex) return; // Not your turn

    // Validate bid? Max bid = cardsInRound.
    if (amount < 0 || amount > _state.cardsInRound) return;

    // Special rule: Sum of bids cannot equal number of cards?
    // (Excludes checking last bidder)
    // Optional, let's skip for simple version or add later.

    final updatedPlayer = _state.players[pIndex].copyWith(bid: amount);
    final newPlayers = List<Player>.from(_state.players)
      ..[pIndex] = updatedPlayer;

    // Next player
    var nextIndex = (_state.currentPlayerIndex + 1) % _state.players.length;
    var nextPhase = GamePhase.bidding;

    // If all have bid (checked by looking if we circled back to starter?
    // Or just count bids?)
    // Easier: Check if everyone has a bid.
    if (newPlayers.every((p) => p.bid != null)) {
      nextPhase = GamePhase.playing;
      // Playing starts with the person Left of Dealer
      // (same as bidding starter usually).
      nextIndex = (_state.dealerIndex + 1) % _state.players.length;
    }

    _state = _state.copyWith(
      players: newPlayers,
      currentPlayerIndex: nextIndex,
      phase: nextPhase,
    );
    _broadcast();
  }

  void _handlePlay(String playerId, PlayingCard card) {
    if (_state.phase != GamePhase.playing) return;
    final pIndex = _state.players.indexWhere((p) => p.id == playerId);
    if (pIndex != _state.currentPlayerIndex) return;

    final player = _state.players[pIndex];
    if (!player.hand.contains(card)) return; // Cheating check

    // Validate Move
    if (!GameLogic.isValidMove(
      card: card,
      hand: player.hand,
      currentTrick: _state.currentTrick,
      trump: _state.trumpCard,
    )) {
      return; // Invalid move
    }

    // Remove from hand
    final newHand = List<PlayingCard>.from(player.hand)..remove(card);
    final updatedPlayer = player.copyWith(hand: newHand);
    final newPlayers = List<Player>.from(_state.players)
      ..[pIndex] = updatedPlayer;

    // Update Trick
    Trick newTrick;
    if (_state.currentTrick == null) {
      newTrick = Trick(
        leadCard: card,
        cardsPlayed: {playerId: card},
        leadPlayerId: playerId,
      );
    } else {
      final newCards =
          Map<String, PlayingCard>.from(_state.currentTrick!.cardsPlayed);
      newCards[playerId] = card;
      newTrick = _state.currentTrick!.copyWith(cardsPlayed: newCards);
    }

    // Check if trick is complete
    if (newTrick.cardsPlayed.length == _state.players.length) {
      _state = _state.copyWith(players: newPlayers, currentTrick: newTrick);
      _resolveTrick(newTrick);
    } else {
      // Next player
      final nextIndex = (_state.currentPlayerIndex + 1) % _state.players.length;
      _state = _state.copyWith(
        players: newPlayers,
        currentTrick: newTrick,
        currentPlayerIndex: nextIndex,
      );
      _broadcast();
    }
  }

  Future<void> _resolveTrick(Trick trick) async {
    _broadcast(); // Show full trick briefly

    // Find winner
    final winnerId = GameLogic.getTrickWinner(trick, _state.trumpCard);

    // Update winner's tricks
    final winnerIndex = _state.players.indexWhere((p) => p.id == winnerId);
    final winner = _state.players[winnerIndex];
    final updatedWinner = winner.copyWith(tricksWon: winner.tricksWon + 1);
    final newPlayers = List<Player>.from(_state.players)
      ..[winnerIndex] = updatedWinner;

    // Wait a moment so players see the result?
    await Future<void>.delayed(
      const Duration(seconds: 1),
    ); // This blocks server? It's async, so fine.

    // Check if round is over (no cards left in hand for anyone - or just 1
    // card left before this trick?)
    // Check first player's hand (which is already updated)
    final roundOver = newPlayers.first.hand.isEmpty;

    if (roundOver) {
      await _endRound(newPlayers);
    } else {
      // Winner leads next trick
      _state = _state.copyWith(
        players: newPlayers,
        currentTrick: null,
        currentPlayerIndex: winnerIndex,
      );
      _broadcast();
    }
  }

  Future<void> _endRound(List<Player> currentPlayers) async {
    // Calculate Scores
    final scoredPlayers = currentPlayers.map((p) {
      final points = GameLogic.calculateScore(p.bid ?? 0, p.tricksWon);
      _logger.info(
        'Player ${p.name}: Bid ${p.bid}, Won ${p.tricksWon} -> Points: $points',
      );
      return p.copyWith(score: p.score + points);
    }).toList();

    _state = _state.copyWith(
      players: scoredPlayers,
      currentTrick: null,
      phase: GamePhase.roundEnd, // Show waiting screen / scoreboard
    );
    _broadcast();

    await Future<void>.delayed(const Duration(seconds: 3));

    // Next Round?
    final nextRoundNum = _state.roundNumber + 1;
    final rounds = GameLogic.getRoundSequence();

    if (nextRoundNum > rounds.length) {
      // Game Over
      _state = _state.copyWith(phase: GamePhase.gameEnd);
      _broadcast();
      return;
    }

    final nextCardsCount = rounds[nextRoundNum - 1];
    final nextDealer = (_state.dealerIndex + 1) % _state.players.length;

    _state = _state.copyWith(
      roundNumber: nextRoundNum,
      cardsInRound: nextCardsCount,
      dealerIndex: nextDealer,
      // phase: GamePhase.bidding // handled in _startRound
    );

    _startRound();
  }

  void _broadcast() {
    final msg = _state.toJson();
    for (final channel in _clients.values) {
      channel.sink.add(msg);
    }
  }
}
