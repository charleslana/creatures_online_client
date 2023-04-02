import 'package:creatures_online_client/pages/home_page.dart';
import 'package:creatures_online_client/pages/landing_page.dart';
import 'package:creatures_online_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouteGenerator {
  AppRouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingRoute:
        return MaterialPageRoute(
          builder: (_) => const LandingPage(),
          settings: settings,
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => SafeArea(
            child: Scaffold(
              body: Center(
                child: Text('Nenhuma rota encontrada para ${settings.name}'),
              ),
            ),
          ),
        );
    }
  }
}
