import 'package:flutter/material.dart';

class PlayerAvatar extends StatelessWidget {
  final String name;
  final int score;
  final int? trickBid;
  final int tricksWon;
  final bool isDealer;
  final bool isCurrentTurn;
  final bool isMe;

  const PlayerAvatar({
    super.key,
    required this.name,
    required this.score,
    this.trickBid,
    this.tricksWon = 0,
    this.isDealer = false,
    this.isCurrentTurn = false,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar Circle
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isMe ? Colors.yellow.shade100 : Colors.grey.shade200,
                shape: BoxShape.circle,
                border: isCurrentTurn
                    ? Border.all(color: Colors.yellow, width: 4)
                    : isMe
                        ? Border.all(color: Colors.white, width: 2)
                        : null,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Center(
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            if (isDealer)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text(
                      "D",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        // Name Label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isMe ? "You" : name,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        // Stats
        const SizedBox(height: 2),
        Text(
          "Score: $score",
          style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              shadows: [Shadow(blurRadius: 2, color: Colors.black)]),
        ),
        if (trickBid != null)
          Text(
            "Bid: $tricksWon / $trickBid",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 2, color: Colors.black)]),
          ),
      ],
    );
  }
}
