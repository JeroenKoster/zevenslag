import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/game/data/game_service.dart';
import 'features/game/logic/game_cubit.dart';
import 'features/lobby/ui/lobby_screen.dart';
import 'theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const ZevenslagApp());
}

class ZevenslagApp extends StatelessWidget {
  const ZevenslagApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GameService(),
      child: BlocProvider(
        create: (context) => GameCubit(context.read<GameService>()),
        child: MaterialApp(
          title: 'Zevenslag',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LobbyScreen(),
        ),
      ),
    );
  }
}
