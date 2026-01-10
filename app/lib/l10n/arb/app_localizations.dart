import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The title of the game
  ///
  /// In en, this message translates to:
  /// **'Zevenslag'**
  String get gameTitle;

  /// Status message when waiting for players to join
  ///
  /// In en, this message translates to:
  /// **'Waiting for players...'**
  String get waitingForPlayers;

  /// Status message when a round is over
  ///
  /// In en, this message translates to:
  /// **'Round Over! Preparing next round...'**
  String get roundOver;

  /// Status message when a trick is complete
  ///
  /// In en, this message translates to:
  /// **'Trick Complete!'**
  String get trickComplete;

  /// Status message indicating it is the user's turn
  ///
  /// In en, this message translates to:
  /// **'YOUR TURN'**
  String get yourTurn;

  /// Status message indicating it is the user's turn to bid
  ///
  /// In en, this message translates to:
  /// **'YOUR BID'**
  String get yourBid;

  /// Status message indicating it is another player's turn
  ///
  /// In en, this message translates to:
  /// **'{playerName}\'s Turn'**
  String playerTurn(String playerName);

  /// Button text to start the game
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// Display text for player score
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String score(int score);

  /// Display text for player bid status (won / bid)
  ///
  /// In en, this message translates to:
  /// **'Bid: {won}/{bid}'**
  String bid(int won, int bid);

  /// Label for the trump card section
  ///
  /// In en, this message translates to:
  /// **'TRUMP'**
  String get trump;

  /// Label when there is no trump suit
  ///
  /// In en, this message translates to:
  /// **'NO TRUMP'**
  String get noTrump;

  /// Message announcing the winner
  ///
  /// In en, this message translates to:
  /// **'{playerName} Wins!'**
  String wins(String playerName);

  /// Label referring to the current user
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// Name of the bidding phase
  ///
  /// In en, this message translates to:
  /// **'BIDDING'**
  String get phaseBidding;

  /// Name of the playing phase
  ///
  /// In en, this message translates to:
  /// **'PLAYING'**
  String get phasePlaying;

  /// Name of the waiting phase
  ///
  /// In en, this message translates to:
  /// **'WAITING'**
  String get phaseWaiting;

  /// Name of the round end phase
  ///
  /// In en, this message translates to:
  /// **'ROUND END'**
  String get phaseRoundEnd;

  /// Name of the game end phase
  ///
  /// In en, this message translates to:
  /// **'GAME OVER'**
  String get phaseGameEnd;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
