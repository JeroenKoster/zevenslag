import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import '../data/game_service.dart';

// States for the UI logic (beyond just the shared GameState, e.g. loading/connecting)
abstract class GameUiState {}

class GameInitial extends GameUiState {}

class GameConnecting extends GameUiState {}

class GameActive extends GameUiState {
  final GameState gameState;
  final String playerId;

  GameActive(this.gameState, this.playerId);
}

class GameError extends GameUiState {
  final String message;
  GameError(this.message);
}

class GameCubit extends Cubit<GameUiState> {
  final GameService _service;
  StreamSubscription? _subscription;
  String? _currentPlayerId;

  GameCubit(this._service) : super(GameInitial());

  void connect(String roomId, String playerName) {
    _currentPlayerId ??= DateTime.now().millisecondsSinceEpoch.toString();

    emit(GameConnecting());

    try {
      _service.connect(roomId, _currentPlayerId!);

      // Join immediately after connecting
      _service.send(JoinMessage(roomId: roomId, playerName: playerName));

      // Listen to updates
      _subscription?.cancel();
      _subscription = _service.stateStream.listen((gameState) {
        emit(GameActive(gameState, _currentPlayerId!));
        _checkAutoPlay(gameState, _currentPlayerId!);
      }, onError: (e) => emit(GameError(e.toString())));
    } catch (e) {
      emit(GameError("Failed to connect: $e"));
    }
  }

  void _checkAutoPlay(GameState gs, String myId) {
    if (gs.phase != GamePhase.playing) return;

    final activePlayerId = gs.players[gs.currentPlayerIndex].id;
    if (activePlayerId != myId) return; // Not my turn

    final me = gs.players.firstWhere((p) => p.id == myId);

    // Calculate valid moves
    final validCards = me.hand
        .where((c) => GameLogic.isValidMove(
              card: c,
              hand: me.hand,
              currentTrick: gs.currentTrick,
              trump: gs.trumpCard,
            ))
        .toList();

    // If only 1 valid option, play it automatically
    if (validCards.length == 1) {
      // Small delay for better UX
      Future.delayed(const Duration(milliseconds: 1000), () {
        // Safety check: Is it still my turn? (In case of fast state changes)
        // Ideally we'd check the latest state, but for this simple logic:
        playCard(validCards.first);
      });
    }
  }

  void startGame() {
    _service.send(const StartMessage());
  }

  void bid(int amount) {
    _service.send(BidMessage(amount: amount));
  }

  void playCard(PlayingCard card) {
    _service.send(PlayMessage(card: card));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _service.dispose();
    return super.close();
  }
}
