import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/models/models.dart';

class CustomSearchDelegate extends SearchDelegate {
  
  String get setSearchFieldLabel => 'Search by name, species, status, type';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<CharacterItemModel> matchQuery = [];
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.characterName),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
