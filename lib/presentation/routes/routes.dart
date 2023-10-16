import 'package:flutter/material.dart';
import 'package:rick_morty_app/presentation/screens/home_screen.dart';

class Routes {
  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
