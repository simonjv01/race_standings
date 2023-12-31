
import 'package:flutter/material.dart';
import 'package:race_standings/routes/home_page.dart';

/// Route management class that handles the navigation among various pages of the
/// app. New routes should be opened in the following ways:
///
/// ```dart
/// Navigator.of(context).pushNamed(RouteGenerator.homePage);
/// Navigator.pushNamed(context, RouteGenerator.homePage);
/// ```
///
/// No differences since both ways are valid.
abstract class RouteGenerator {
  /// Route name for the home page of the app.
  static const home = '/';

  /// Route name for the settings page.
  static const nextRacesPage = '/next_races';

  /// Making the constructor private since this class is not meant to be
  /// instantiated.
  const RouteGenerator._();

  /// The "dispatcher" that assigns a route name to a particular widget.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return PageRouteBuilder<HomePage>(
          settings: settings,
          pageBuilder: (_, __, ___) => const HomePage(),
        );

      case nextRacesPage:
        return PageRouteBuilder<NextRacesPage>(
          settings: settings,
          pageBuilder: (_, __, ___) => const NextRacesPage(),
        );

      default:
        throw const RouteException('Route not found');
    }
  }
}

/// Exception to be thrown when the route being pushed doesn't exist.
class RouteException implements Exception {
  /// The error message.
  final String message;

  /// Requires the error [message] to be shown when a route is not found.
  const RouteException(this.message);
}