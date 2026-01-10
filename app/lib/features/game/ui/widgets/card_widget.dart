import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardWidget extends StatelessWidget {
  final PlayingCard?
      card; // Nullable for "unknown" card backs if needed, usually null if isFaceDown is true for opponent
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isFaceDown;
  final double width;
  final double height;

  const CardWidget({
    super.key,
    this.card,
    this.onTap,
    this.isSelected = false,
    this.isFaceDown = false,
    this.width = 60,
    this.height = 90,
  });

  @override
  Widget build(BuildContext context) {
    if (isFaceDown) {
      return GestureDetector(
        onTap: onTap,
        child: _buildCardBack(),
      );
    }

    if (card == null) return SizedBox(width: width, height: height);

    final Color color =
        (card!.suit == Suit.hearts || card!.suit == Suit.diamonds)
            ? Colors.red
            : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Transform.translate(
        offset: isSelected ? const Offset(0, -15) : Offset.zero,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Center Suit
              Center(
                child: Icon(
                  _suitIcon(card!.suit),
                  color: color.withValues(alpha: 0.15),
                  size: width * 0.7,
                ),
              ),
              // Top Left Rank
              Positioned(
                top: 2,
                left: 2,
                child: Column(
                  children: [
                    Text(
                      _rankStr(card!.rank),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Icon(_suitIcon(card!.suit), color: color, size: 12),
                  ],
                ),
              ),
              // Bottom Right Rank (Rotated)
              Positioned(
                bottom: 2,
                right: 2,
                child: Transform.rotate(
                  angle: 3.14159,
                  child: Column(
                    children: [
                      Text(
                        _rankStr(card!.rank),
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Icon(_suitIcon(card!.suit), color: color, size: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: width * 0.8,
          height: height * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade700, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          // Use a neutral icon for the back pattern
          child: Icon(CupertinoIcons.sparkles,
              color: Colors.blue.shade300.withValues(alpha: 0.5), size: 16),
        ),
      ),
    );
  }

  String _rankStr(Rank r) {
    if (r.value <= 10) return r.value.toString();
    return r.name[0].toUpperCase();
  }

  IconData _suitIcon(Suit s) {
    switch (s) {
      case Suit.clubs:
        return CupertinoIcons.suit_club_fill;
      case Suit.diamonds:
        return CupertinoIcons.suit_diamond_fill;
      case Suit.hearts:
        return CupertinoIcons.suit_heart_fill;
      case Suit.spades:
        return CupertinoIcons.suit_spade_fill;
    }
  }
}
