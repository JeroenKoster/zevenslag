import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'card_widget.dart';

class TableArea extends StatelessWidget {
  final Trick? trick;
  final PlayingCard? trump;
  final String status;

  const TableArea({
    super.key,
    required this.trick,
    required this.trump,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade800,
      width: double.infinity,
      child: Stack(
        children: [
          // Status Text
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Text(
              status,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Trump Card (Top Left)
          if (trump != null)
            Positioned(
              top: 20,
              left: 20,
              child: Column(
                children: [
                  const Text(
                    "TRUMP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CardWidget(card: trump!),
                ],
              ),
            ),

          // Current Trick (Center)
          if (trick != null)
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: trick!.cardsPlayed.values
                    .map((c) => CardWidget(card: c))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
