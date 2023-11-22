import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Response;
import 'package:http/testing.dart' show MockClient;
import 'package:rick_morty_app/data/datasource/remote/rick_morty_datasource_impl.dart';
import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import 'package:rick_morty_app/domain/viewmodels/episodes_filter.dart';
import 'package:rick_morty_app/domain/viewmodels/locations_filter.dart';
import 'package:rick_morty_app/utils/enums.dart';

void main() {
  test('Characters, call api to parse rick and morty character, success',
      () async {
    final datasource = _getDatasource('test/responses/characters.json');
    final character = await datasource.getCharacters(page: 1);
    expect(character.isLeft, false);
    expect(character.right?.results?.length, 3);

    character.when((p0) => expect('error', 'error'), (response) {
      expect(response.results![0].characterName, 'Rick Sanchez');
      expect(response.results![0].characterStatus, StatusCharacter.alive);
    });
  });

  test(
      'Filter Characters, call api to parse rick and morty character filtered, success',
      () async {
    final datasource = _getDatasource('test/responses/characters.json');
    final character = await datasource.filterCharacters(
        CharacterFilters(name: '', gender: GenderCharacter.female));
    expect(character.isLeft, false);
    expect(character.right?.results?.length, 3);

    character.when((p0) => expect('error', 'error'), (response) {
      expect(response.results![0].characterName, 'Rick Sanchez');
      expect(response.results![0].characterStatus, StatusCharacter.alive);
    });
  });

  test('Episodes, call api to get episodes with 3 items, success', () async {
    final datasource = _getDatasource('test/responses/episodes.json');
    final episodes = await datasource.getEpisodes(page: 3);

    expect(episodes.isLeft, false);
    expect(episodes.right?.results?.length, 3);

    episodes.when((p0) => expect('error', 'error'), (response) {
      expect(response.results![0].episodeName, 'Pilot');
      expect(response.results![0].episode, 'S01E01');
    });
  });

  test('Filter Episodes, call api to get episodes with 3 items, success',
      () async {
    final datasource = _getDatasource('test/responses/episodes.json');
    final episodes = await datasource
        .filterEpisodes(EpisodeFilters(name: '', episode: 'S01E01'));

    expect(episodes.isLeft, false);
    expect(episodes.right?.results?.length, 3);

    episodes.when((p0) => expect('error', 'error'), (response) {
      expect(response.results![0].episodeName, 'Pilot');
      expect(response.results![0].episode, 'S01E01');
    });
  });

  test('Locations, call api to get locations with 3 items, success', () async {
    final datasource = _getDatasource('test/responses/locations.json');
    final episodes = await datasource.getLocations(page: 3);

    expect(episodes.isLeft, false);
    expect(episodes.right?.results?.length, 4);

    episodes.when((p0) => expect('error', 'error'), (response) {
      expect(response.results![0].locationType, 'Planet');
      expect(response.results![3].dimension, "unknown");
    });
  });

  test('Filter Locations, call api to get locations with 3 items, success',
      () async {
    final datasource = _getDatasource('test/responses/locations.json');
    final episodes = await datasource
        .filterLocations(LocationFilters(name: 'Locura', type: 'Planet'));

    expect(episodes.isLeft, false);
    expect(episodes.right?.results?.length, 4);

    episodes.when((p0) => expect('error', 'error'), (response) {
      expect(response.results![0].locationType, 'Planet');
      expect(response.results![3].dimension, "unknown");
    });
  });
}

RickMortyRemoteDatasource _getDatasource(String path) =>
    RickMortyRemoteDatasource(
        httpApp: HttpApp(
      client: _getMockProvider(path),
    ));

MockClient _getMockProvider(String filePath) => MockClient(
    (_) async => Response(await File(filePath).readAsString(), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }));
