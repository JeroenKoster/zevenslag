import '../models/card.dart';
import '../models/game_state.dart';
// import '../models/player.dart'; // Unused here? Wait, calculateScore uses it? No, calculateScore uses ints.

class GameLogic {
  /// Returns the sequence of hand sizes for the 14 rounds.
  /// 1..7 then 7..1
  static List<int> getRoundSequence() {
    // 1 (blind), 1..7, 7..1, 1 (blind)
    return [1, 1, 2, 3, 4, 5, 6, 7, 7, 6, 5, 4, 3, 2, 1, 1];
  }

  static bool isBlindRound(int roundNumber) {
    return roundNumber == 1 || roundNumber == 16;
  }

  /// Calculates points for a round.
  /// [bid] is what was predicted.
  /// [won] is actual tricks won.
  static int calculateScore(int bid, int won) {
    if (bid == won) {
      return 5 + (3 * won);
    } else {
      final diff = (bid - won).abs();
      // Penalty logic: "vermijd strafpunten" implies losing points.
      // Plan was -2 per difference.
      return -2 * diff;
    }
  }

  /// Validates if a card can be played.
  static bool isValidMove({
    required PlayingCard card,
    required List<PlayingCard> hand,
    required Trick? currentTrick,
    required PlayingCard? trump,
  }) {
    // If leading (no trick or empty trick), any card is valid.
    if (currentTrick == null || currentTrick.cardsPlayed.isEmpty) {
      return true;
    }

    final leadCard = currentTrick.leadCard;
    final leadSuit = leadCard.suit;

    // If player has the lead suit, they MUST play it (Color Obligation / "Kleur bekennen")
    final hasLeadSuit = hand.any((c) => c.suit == leadSuit);

    if (hasLeadSuit) {
      return card.suit == leadSuit;
    }

    // If they don't have lead suit, they can play anything (including trump).
    return true;
  }

  /// Determines the winner of a trick.
  static String getTrickWinner(Trick trick, PlayingCard? trump) {
    if (trick.cardsPlayed.isEmpty) throw Exception("Empty trick");

    String currentWinnerId = trick.leadPlayerId;
    PlayingCard winningCard = trick.leadCard;

    trick.cardsPlayed.forEach((playerId, card) {
      if (playerId == trick.leadPlayerId) return; // Skip lead, already set

      // Check if current card beats the winning card so far
      if (_beats(card, winningCard, trump, trick.leadCard.suit)) {
        winningCard = card;
        currentWinnerId = playerId;
      }
    });

    return currentWinnerId;
  }

  /// Returns true if [challenger] beats [defender].
  static bool _beats(
    PlayingCard challenger,
    PlayingCard defender,
    PlayingCard? trump,
    Suit leadSuit,
  ) {
    // If challenger is trump and defender is not, challenger wins.
    if (trump != null) {
      if (challenger.suit == trump.suit && defender.suit != trump.suit) {
        return true;
      }
      if (defender.suit == trump.suit && challenger.suit != trump.suit) {
        return false;
      }
      // Both trumps: higher rank wins
      if (challenger.suit == trump.suit && defender.suit == trump.suit) {
        return challenger.rank.value > defender.rank.value;
      }
    }

    // If neither is trump (or no trump), check lead suit.
    if (challenger.suit == leadSuit && defender.suit != leadSuit) {
      // If defender wasn't trump (handled above) and isn't lead suit, challenger wins?
      // Wait, if defender is random suit and challenger is lead suit?
      // Standard rule: Only lead suit or trump can win. Random off-suit never wins against lead suit.
      return true;
    }

    if (challenger.suit == leadSuit && defender.suit == leadSuit) {
      return challenger.rank.value > defender.rank.value;
    }

    // If challenger is off-suit (and not trump), it can't beat defender effectively unless defender is also off-suit?
    // Actually, simply:
    // 1. Trump beats non-trump.
    // 2. High trump beats low trump.
    // 3. Lead suit beats non-lead-suit (unless trump).
    // 4. High lead suit beats low lead suit.

    return false;
  }
}
