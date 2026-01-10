import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'card_widget.dart';
import 'player_avatar.dart';

class GameTable extends StatelessWidget {
  final List<Player> players;
  final Player me;
  final Trick? currentTrick;
  final PlayingCard? trumpCard;
  final int currentPlayerIndex;
  final int dealerIndex;
  final String? winnerId;
  final int roundNumber;

  const GameTable({
    super.key,
    required this.players,
    required this.me,
    required this.currentTrick,
    required this.trumpCard,
    required this.currentPlayerIndex,
    required this.dealerIndex,
    required this.roundNumber,
    this.winnerId,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final centerX = w / 2;
        final centerY = h / 2;

        // Position me at bottom
        // Position others around top/left/right depending on count (max 4 supported nicely)
        final otherPlayers = _getOrderedOpponents();

        return Stack(
          children: [
            // Green Felt Background
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.green.shade700, Colors.green.shade900],
                  radius: 1.2,
                  center: Alignment.center,
                ),
              ),
            ),

            // Trump Card Indicator (Top Left)
            if (trumpCard != null)
              Positioned(
                top: 20,
                left: 20,
                child: Column(
                  children: [
                    const Text("TRUMP",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    CardWidget(card: trumpCard!, width: 50, height: 75),
                  ],
                ),
              ),

            if (trumpCard == null) // No Trump
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white30),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text("NO TRUMP",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                ),
              ),

            // Neighbors
            ..._buildPlayerSeats(w, h, otherPlayers),

            // Center Trick Area
            Positioned(
              left: centerX - 100, // Approximate area width 200
              top: centerY - 100, // Approximate area height 200
              width: 200,
              height: 200,
              child: _buildTrickPile(),
            ),

            // Winner Indicator
            if (winnerId != null)
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.yellow, width: 2),
                  ),
                  child: Text(
                    "${_getPlayerName(winnerId!)} Wins!",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  List<Player> _getOrderedOpponents() {
    final myIndex = players.indexOf(me);
    // Rotate list so ME is first, then take the rest
    final rotated = [
      ...players.sublist(myIndex),
      ...players.sublist(0, myIndex)
    ];
    return rotated.skip(1).toList();
  }

  String _getPlayerName(String id) {
    return players
        .firstWhere((p) => p.id == id,
            orElse: () => Player(id: '', name: 'Unknown'))
        .name;
  }

  List<Widget> _buildPlayerSeats(
      double tableWidth, double tableHeight, List<Player> opponents) {
    final widgets = <Widget>[];

    // Standard positions for up to 3 opponents (4 player game)
    // 1 Opponent: Top
    // 2 Opponents: TopLeft, TopRight
    // 3 Opponents: Left, Top, Right

    final positions = <Alignment>[];
    if (opponents.length == 1) {
      positions.add(Alignment.topCenter);
    } else if (opponents.length == 2) {
      positions.add(const Alignment(-0.6, -0.8)); // Top Leftish
      positions.add(const Alignment(0.6, -0.8)); // Top Rightish
    } else {
      positions.add(Alignment.centerLeft);
      positions.add(Alignment.topCenter);
      positions.add(Alignment.centerRight);
    }

    // Avatar + Cards
    for (int i = 0; i < opponents.length; i++) {
      final p = opponents[i];
      final align = positions[i];

      // Calculate Offset from alignment
      double left, top;

      if (align == Alignment.topCenter) {
        left = tableWidth / 2 - 40;
        top = 20;
      } else if (align == Alignment.centerLeft) {
        left = 20;
        top = tableHeight / 2 - 40;
      } else if (align == Alignment.centerRight) {
        left = tableWidth - 100;
        top = tableHeight / 2 - 40;
      } else {
        // Custom coordinates for 2 opponents
        left = (tableWidth / 2) + (align.x * (tableWidth / 2.5)) - 40;
        top = (tableHeight / 2) + (align.y * (tableHeight / 2.5)) - 40;
      }

      widgets.add(Positioned(
        left: left,
        top: top,
        child: Column(
          children: [
            PlayerAvatar(
              name: p.name,
              score: p.score,
              trickBid: p.bid,
              tricksWon: p.tricksWon,
              isDealer: players[dealerIndex].id == p.id,
              isCurrentTurn: players[currentPlayerIndex].id == p.id,
            ),
            const SizedBox(height: 8),
            // Show small card backs for their hand
            SizedBox(
              height: 40,
              width: 80,
              child: Stack(
                children: List.generate(p.hand.length, (index) {
                  return Positioned(
                    left: index * 10.0,
                    child: CardWidget(
                        card: GameLogic.isBlindRound(roundNumber)
                            ? p.hand[index]
                            : null,
                        isFaceDown: !GameLogic.isBlindRound(roundNumber),
                        width: 25,
                        height: 38),
                  );
                }),
              ),
            )
          ],
        ),
      ));
    }

    // Add ME (Bottom Center) - Avatar only (Hand is separate in main screen)
    // Actually, maybe we put "Me" avatar near the hand area in main screen?
    // Or put it just above the hand here?
    // Let's put it at bottom left of the table for stats.
    widgets.add(Positioned(
      bottom: 20,
      left: 20,
      child: PlayerAvatar(
        name: me.name,
        score: me.score,
        trickBid: me.bid,
        tricksWon: me.tricksWon,
        isDealer: players[dealerIndex].id == me.id,
        isCurrentTurn: players[currentPlayerIndex].id == me.id,
        isMe: true,
      ),
    ));

    return widgets;
  }

  Widget _buildTrickPile() {
    if (currentTrick == null || currentTrick!.cardsPlayed.isEmpty) {
      return const Center(
          child: Text("Waiting...", style: TextStyle(color: Colors.white10)));
    }

    // Scatter cards in center? Or arrange neatly?
    // Let's arrange them based on player position? That's hard without knowing absolute positions.
    // Random rotation stack is classic.

    final cards = currentTrick!.cardsPlayed.values.toList();

    return Stack(
      alignment: Alignment.center,
      children: cards.asMap().entries.map((entry) {
        final index = entry.key;
        final card = entry.value;
        // Slight random rotation and offset based on index to see them all slightly
        final offset = index * 10.0;
        return Transform.translate(
          offset: Offset(offset - (cards.length * 5), 0),
          child: Transform.rotate(
            angle: (index - 1) * 0.2,
            child: CardWidget(card: card, width: 70, height: 100),
          ),
        );
      }).toList(),
    );
  }
}
