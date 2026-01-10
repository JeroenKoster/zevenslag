import 'package:dart_mappable/dart_mappable.dart';
import 'card.dart';
import 'player.dart';

part 'game_state.mapper.dart';

@MappableEnum()
enum GamePhase { waiting, bidding, playing, roundEnd, gameEnd }

@MappableClass()
class Trick with TrickMappable {
  final PlayingCard leadCard;
  final Map<String, PlayingCard> cardsPlayed;
  final String leadPlayerId;

  const Trick({
    required this.leadCard,
    required this.cardsPlayed,
    required this.leadPlayerId,
  });

  static Trick fromJson(Map<String, dynamic> json) => TrickMapper.fromMap(json);
}

@MappableClass()
class GameState with GameStateMappable {
  final String id;
  final List<Player> players;
  final GamePhase phase;
  final int roundNumber;
  final int cardsInRound;
  final PlayingCard? trumpCard;
  final Trick? currentTrick;
  final int currentPlayerIndex;
  final int dealerIndex;
  final String? winnerId;

  const GameState({
    required this.id,
    this.players = const [],
    this.phase = GamePhase.waiting,
    this.roundNumber = 1,
    this.cardsInRound = 1,
    this.trumpCard,
    this.currentTrick,
    this.currentPlayerIndex = 0,
    this.dealerIndex = 0,
    this.winnerId,
  });

  static GameState fromJson(Map<String, dynamic> json) =>
      GameStateMapper.fromMap(json);
}
