import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'card_widget.dart';

class HandArea extends StatelessWidget {
  final List<PlayingCard> cards;
  final bool canPlay;
  final bool isFaceDown;
  final Function(PlayingCard) onCardTap;

  const HandArea({
    super.key,
    required this.cards,
    required this.canPlay,
    this.isFaceDown = false,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade900,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cards.map((card) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Opacity(
                opacity: canPlay ? 1.0 : 0.6,
                child: CardWidget(
                  card: cards[cards.indexOf(
                      card)], // Actually just 'card' works but keeping context
                  isFaceDown: isFaceDown,
                  onTap: canPlay ? () => onCardTap(card) : null,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
