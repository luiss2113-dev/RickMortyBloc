import '../global/widgets.dart';
import 'widget/widget.dart';
import 'package:rick_morty_app/presentation/screens/global/widgets/error_view.dart';
import 'package:rick_morty_app/presentation/blocs/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            
        if (state.error != '') {
          return CustomError(
            errorDetails: FlutterErrorDetails(exception: state.error),
            onRefresh: () => context.read<CharacterCubit>().loadCharacters(),
          );
        }

        if (state.charactersCurrent.isNotEmpty) {
          return CharacterRender(
              characters: state.charactersCurrent,
              onfechMore: () => context
                  .read<CharacterCubit>()
                  .loadCharacters(page: state.page + 1));
        }

        return const CircularProgressIndicator(); //TODO: implement shimmer view
      })),
    );
  }
}
