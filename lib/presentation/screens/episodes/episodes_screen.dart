import 'package:rick_morty_app/presentation/blocs/blocs.dart';
import 'package:rick_morty_app/presentation/screens/episodes/widget/widget.dart'
    show EpisodeContainer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import '../global/widgets.dart' show CustomError;

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(
        child: BlocBuilder<EpisodeBloc, EpisodeState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            switch (state.state) {
              case BlocState.error:
                return CustomError(
                  errorDetails:
                      FlutterErrorDetails(exception: state.messageError),
                  onRefresh: () =>
                      context.read<EpisodeBloc>().add(const GetEpisodeEvent()),
                );
              case BlocState.loaded:
                return const EpisodeContainer();
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
