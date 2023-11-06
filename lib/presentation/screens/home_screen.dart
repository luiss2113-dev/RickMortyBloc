import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

import '../../domain/rick_morty_repository.dart';
import '../blocs/blocs.dart' as bloc;
import '../routes/routes.dart';

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
      body: _bodyScreen(selectedPageIndex),
      bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 60,
          elevation: 2,
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: Routes.menuNavigators()),
    );
  }

  _bodyScreen(int index) {
    return [
      BlocProvider(
        create: (context) =>
            bloc.CharacterBloc(context.read<RickMortyRepository>())
              ..add(const bloc.GetCharacterEvent()),
        child: const CharactersScreen(),
      ),
      const EpisodesScreen(),
      const LocationsScreen()
    ][index];
  }
}
