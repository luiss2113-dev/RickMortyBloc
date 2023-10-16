import 'widget/widget.dart';
import 'package:rick_morty_app/presentation/screens/global/widgets/error_view.dart';
import 'package:rick_morty_app/presentation/blocs/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../global/widgets.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
        if (state.isError) {
          return CustomError(
            errorDetails: FlutterErrorDetails(exception: state.errorCurrent),
            onRefresh: () => context.read<CharacterCubit>().loadCharacters(),
          );
        }

        if (!state.isEmpty) {
          return const CharacterRender();
        }

        return const CircularProgressIndicator(); //TODO: implement shimmer view
      })),
    );
  }
}
