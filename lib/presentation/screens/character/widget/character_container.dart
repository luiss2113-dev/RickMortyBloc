import 'package:rick_morty_app/presentation/screens/global/widgets/response_body.dart';

import 'widget.dart' show CharacterItem;
import 'package:rick_morty_app/presentation/blocs/blocs.dart'
    show CharacterState, GetCharacterEvent, CharacterBloc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

class CharacterContainer extends StatelessWidget {
  const CharacterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponseBody(
      action: () =>
          context.read<CharacterBloc>().add(const GetCharacterEvent()),
      title: 'Personajes',
      child: const ListBodyCharacter(),
    );
  }
}

class ListBodyCharacter extends StatelessWidget {
  const ListBodyCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      buildWhen: (previous, current) =>
          previous.characters != current.characters,
      builder: (context, state) {
        final characters = state.characters.results;
        return SliverList.builder(
          itemCount: characters!.length,
          itemBuilder: (context, index) {
            return CharacterItem(
              character: characters[index],
            );
          },
        );
      },
    );
  }
}
