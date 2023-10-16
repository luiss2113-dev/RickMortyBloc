import 'package:flutter/material.dart';
import 'package:rick_morty_app/presentation/screens/screens.dart';

import 'global/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        CharactersScreen(),
        EpisodesScreen(),
        LocationsScreen()
      ][selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 2,
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: MyIcon(
              icon: Icons.person_4_outlined,
              isSelected: true,
            ),
            icon: MyIcon(icon: Icons.person_4_rounded),
            label: 'Characters',
          ),
          NavigationDestination(
            selectedIcon: MyIcon(
              icon: Icons.view_carousel_outlined,
              isSelected: true,
            ),
            icon: MyIcon(icon: Icons.view_carousel_rounded),
            label: 'Episodes',
          ),
          NavigationDestination(
            selectedIcon: MyIcon(
              icon: Icons.location_on_outlined,
              isSelected: true,
            ),
            icon: MyIcon(icon: Icons.location_on_rounded),
            label: 'Locations',
          ),
        ],
      ),
    );
  }
}
