import 'package:dart_mappable/dart_mappable.dart';
import 'card.dart';

part 'player.mapper.dart';

@MappableClass()
class Player with PlayerMappable {
  final String id;
  final String name;
  final List<PlayingCard> hand;
  final int? bid;
  final int tricksWon;
  final int score;
  final bool isReady;

  const Player({
    required this.id,
    required this.name,
    this.hand = const [],
    this.bid,
    this.tricksWon = 0,
    this.score = 0,
    this.isReady = false,
  });

  static Player fromJson(Map<String, dynamic> json) =>
      PlayerMapper.fromMap(json);
}
