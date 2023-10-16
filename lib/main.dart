import 'package:rick_morty_app/presentation/app.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/domain/repository/rick_morty_respository_impl.dart';
import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/datasource/remote/rick_morty_datasource_impl.dart';
import 'presentation/blocs/blocs.dart';

void main() {
  final datasource =
      RickMortyRemoteDatasource(httpApp: HttpApp(client: Client()));
  final repository =
      RickAndMortyRepositoryImpl(rickMortyDataSource: datasource);

  runApp(RepositoryProvider<RickMortyRepository>(
      create: (_) => repository,
      child: MultiBlocProvider(providers: [
        BlocProvider<CharacterCubit>(
          create: (context) =>
              CharacterCubit(context.read<RickMortyRepository>())
                ..loadCharacters(),
        ),
        BlocProvider<EpisodeCubit>(
          create: (context) =>
              EpisodeCubit(context.read<RickMortyRepository>())..loadEpisodes(),
        ),
        BlocProvider<LocationCubit>(
          create: (context) =>
              LocationCubit(context.read<RickMortyRepository>())
                ..loadLocations(),
        )
      ], child: const MyApp())));
}
