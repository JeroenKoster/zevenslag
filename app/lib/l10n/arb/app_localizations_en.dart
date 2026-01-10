// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get gameTitle => 'Zevenslag';

  @override
  String get waitingForPlayers => 'Waiting for players...';

  @override
  String get roundOver => 'Round Over! Preparing next round...';

  @override
  String get trickComplete => 'Trick Complete!';

  @override
  String get yourTurn => 'YOUR TURN';

  @override
  String get yourBid => 'YOUR BID';

  @override
  String playerTurn(String playerName) {
    return '$playerName\'s Turn';
  }

  @override
  String get startGame => 'Start Game';

  @override
  String score(int score) {
    return 'Score: $score';
  }

  @override
  String bid(int won, int bid) {
    return 'Bid: $won/$bid';
  }

  @override
  String get trump => 'TRUMP';

  @override
  String get noTrump => 'NO TRUMP';

  @override
  String wins(String playerName) {
    return '$playerName Wins!';
  }

  @override
  String get you => 'You';

  @override
  String get phaseBidding => 'BIDDING';

  @override
  String get phasePlaying => 'PLAYING';

  @override
  String get phaseWaiting => 'WAITING';

  @override
  String get phaseRoundEnd => 'ROUND END';

  @override
  String get phaseGameEnd => 'GAME OVER';
}
