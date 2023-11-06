import 'package:flutter/material.dart';
import 'package:rick_morty_app/presentation/screens/home_screen.dart';

import '../screens/global/widgets.dart';

class Routes {
  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }

  static List<NavigationDestination> menuNavigators() {
    return [
      const NavigationDestination(
        selectedIcon: MyIcon(
          icon: Icons.person_4_outlined,
          isSelected: true,
        ),
        icon: MyIcon(icon: Icons.person_4_rounded),
        label: 'Characters',
      ),
      const NavigationDestination(
        selectedIcon: MyIcon(
          icon: Icons.view_carousel_outlined,
          isSelected: true,
        ),
        icon: MyIcon(icon: Icons.view_carousel_rounded),
        label: 'Episodes',
      ),
      const NavigationDestination(
        selectedIcon: MyIcon(
          icon: Icons.location_on_outlined,
          isSelected: true,
        ),
        icon: MyIcon(icon: Icons.location_on_rounded),
        label: 'Locations',
      ),
    ];
  }
}
