import 'package:rick_morty_app/presentation/app.dart' show MyApp;
import 'package:rick_morty_app/domain/rick_morty_repository.dart'
    show RickMortyRepository;
import 'package:rick_morty_app/domain/repository/rick_morty_respository_impl.dart'
    show RickAndMortyRepositoryImpl;
import 'package:rick_morty_app/data/helpers/http_app.dart' show HttpApp;
import 'package:http/http.dart' show Client;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show RepositoryProvider, MultiBlocProvider, BlocProvider, ReadContext;
import 'data/datasource/remote/rick_morty_datasource_impl.dart'
    show RickMortyRemoteDatasource;
import 'presentation/blocs/blocs.dart';

void main() {
  final datasource =
      RickMortyRemoteDatasource(httpApp: HttpApp(client: Client()));
  final repository =
      RickAndMortyRepositoryImpl(rickMortyDataSource: datasource);

  runApp(RepositoryProvider<RickMortyRepository>(
      create: (_) => repository,
      child: MultiBlocProvider(providers: [
        BlocProvider<CharacterBloc>(
            create: (context) =>
                CharacterBloc(context.read<RickMortyRepository>())
                  ..add(const GetCharacterEvent())),
        BlocProvider<EpisodeBloc>(
          create: (context) =>
              EpisodeBloc((context.read<RickMortyRepository>()))
                ..add(const GetEpisodeEvent()),
        ),
        BlocProvider<LocationsBloc>(
          create: (context) =>
              LocationsBloc(context.read<RickMortyRepository>())
                ..add(const GetLocationsEvent()),
        )
      ], child: const MyApp())));
}
