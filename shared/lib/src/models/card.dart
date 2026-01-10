import 'package:dart_mappable/dart_mappable.dart';

part 'card.mapper.dart';

@MappableEnum()
enum Suit {
  clubs,
  diamonds,
  hearts,
  spades;

  @override
  String toString() => name;
}

@MappableEnum()
enum Rank {
  two(2),
  three(3),
  four(4),
  five(5),
  six(6),
  seven(7),
  eight(8),
  nine(9),
  ten(10),
  jack(11),
  queen(12),
  king(13),
  ace(14);

  final int value;
  const Rank(this.value);

  @override
  String toString() => name;
}

@MappableClass()
class PlayingCard with PlayingCardMappable {
  final Suit suit;
  final Rank rank;

  const PlayingCard({required this.suit, required this.rank});

  @override
  String toString() => '${rank.name} of ${suit.name}';

  // Custom fromJson if needed or rely on container default
  static PlayingCard fromJson(Map<String, dynamic> json) =>
      PlayingCardMapper.fromMap(json);
}

@MappableClass()
class Deck with DeckMappable {
  final List<PlayingCard> cards;

  const Deck({required this.cards});

  factory Deck.standard() {
    final cards = <PlayingCard>[];
    for (final suit in Suit.values) {
      for (final rank in Rank.values) {
        cards.add(PlayingCard(suit: suit, rank: rank));
      }
    }
    return Deck(cards: cards);
  }

  Deck shuffled() {
    final newCards = List<PlayingCard>.from(cards)..shuffle();
    return Deck(cards: newCards);
  }

  ({List<PlayingCard> drawn, Deck remaining}) draw(int count) {
    if (count > cards.length) {
      throw Exception('Not enough cards in deck');
    }
    final drawn = cards.take(count).toList();
    final remaining = cards.skip(count).toList();
    return (drawn: drawn, remaining: Deck(cards: remaining));
  }
}
