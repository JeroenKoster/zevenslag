import 'package:app/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart'; // For GamePhase
import '../logic/game_cubit.dart';

import 'widgets/game_table.dart';
import 'widgets/hand_area.dart';
import 'widgets/scoreboard.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    // ...
    return BlocBuilder<GameCubit, GameUiState>(
      builder: (context, state) {
        if (state is! GameActive) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final gs = state.gameState;
        final myId = state.playerId;
        final me = gs.players.firstWhere(
          (p) => p.id == myId,
          orElse: () => gs.players.first,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Round ${gs.roundNumber} - ${_getPhaseName(gs.phase, l10n)}",
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Scoreboard(players: gs.players),
                  );
                },
                icon: const Icon(Icons.leaderboard),
              ),
            ],
          ),
          body: Container(
            color: theme.scaffoldBackgroundColor, // Use theme color
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: GameTable(
                    players: gs.players,
                    me: me,
                    currentTrick: gs.currentTrick,
                    trumpCard: gs.trumpCard,
                    currentPlayerIndex: gs.currentPlayerIndex,
                    dealerIndex: gs.dealerIndex,
                    winnerId: gs.winnerId,
                    roundNumber: gs.roundNumber,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: theme.colorScheme.surface, // Use theme surface
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black
                                  .withValues(alpha: 0.26), // Modern syntax
                              offset: const Offset(0, -2),
                              blurRadius: 4)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            _getStatusText(gs, me, l10n),
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (gs.phase == GamePhase.bidding &&
                            gs.currentPlayerIndex == gs.players.indexOf(me))
                          _buildBiddingControls(context, gs.cardsInRound),
                        if (gs.phase == GamePhase.waiting &&
                            gs.players.length >= 2)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ElevatedButton(
                              style: theme.elevatedButtonTheme.style,
                              onPressed: () =>
                                  context.read<GameCubit>().startGame(),
                              child: Text(l10n.startGame,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        Expanded(
                          child: HandArea(
                            cards: me.hand,
                            canPlay: gs.phase == GamePhase.playing &&
                                gs.currentPlayerIndex == gs.players.indexOf(me),
                            isFaceDown: GameLogic.isBlindRound(gs.roundNumber),
                            onCardTap: (card) {
                              context.read<GameCubit>().playCard(card);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getStatusText(GameState gs, Player me, AppLocalizations l10n) {
    if (gs.phase == GamePhase.waiting) return l10n.waitingForPlayers;
    if (gs.phase == GamePhase.roundEnd) return l10n.roundOver;

    if (gs.winnerId != null) return l10n.trickComplete;

    final activePlayer = gs.players[gs.currentPlayerIndex];
    if (activePlayer.id == me.id) {
      if (gs.phase == GamePhase.bidding) return l10n.yourBid;
      return l10n.yourTurn;
    }
    return l10n.playerTurn(activePlayer.name);
  }

  // Opponents build method deleted as it's now in GameTable

  String _getPhaseName(GamePhase phase, AppLocalizations l10n) {
    switch (phase) {
      case GamePhase.waiting:
        return l10n.phaseWaiting;
      case GamePhase.bidding:
        return l10n.phaseBidding;
      case GamePhase.playing:
        return l10n.phasePlaying;
      case GamePhase.roundEnd:
        return l10n.phaseRoundEnd;
      case GamePhase.gameEnd:
        return l10n.phaseGameEnd;
    }
  }

  Widget _buildBiddingControls(BuildContext context, int maxBid) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: maxBid + 1,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text("$i",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  context.read<GameCubit>().bid(i);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
