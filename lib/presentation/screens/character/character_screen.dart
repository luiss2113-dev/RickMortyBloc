import '../../blocs/blocs.dart';
import 'widget/widget.dart';
import 'package:rick_morty_app/presentation/screens/global/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../global/widgets.dart';

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
                return const CharacterRender();
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
