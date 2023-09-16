import 'package:flutter/material.dart';
import 'package:race_standings/localization/localization.dart';

void main() {
  runApp(const RaceStandingsApp());
}

class RaceStandingsApp extends StatelessWidget {
  const RaceStandingsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    // Localized app title
        onGenerateTitle: (context) =>
      context.l10n.app_title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // Routing setup
        onGenerateRoute: Route

    )}
}

