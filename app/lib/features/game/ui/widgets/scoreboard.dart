import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class Scoreboard extends StatelessWidget {
  final List<Player> players;

  const Scoreboard({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    // Sort by score
    final sorted = List<Player>.from(players)
      ..sort((a, b) => b.score.compareTo(a.score));

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Scoreboard",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...sorted.map(
            (p) => ListTile(
              leading: CircleAvatar(child: Text(p.name[0])),
              title: Text(p.name),
              trailing: Text(
                "${p.score} pts",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
