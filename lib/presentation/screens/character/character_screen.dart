import '../../blocs/blocs.dart'
    show CharacterBloc, CharacterState, BlocState, GetCharacterEvent;
import 'widget/widget.dart' show CharacterContainer;
import 'package:rick_morty_app/presentation/screens/global/widgets/error_view.dart'
    show CustomError;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(
        child: BlocBuilder<CharacterBloc, CharacterState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            switch (state.state) {
              case BlocState.loaded:
                return const CharacterContainer();
              case BlocState.error:
                return CustomError(
                  errorDetails: FlutterErrorDetails(
                    exception: state.messageError,
                  ),
                  onRefresh: () => context.read<CharacterBloc>()
                    ..add(const GetCharacterEvent()),
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
