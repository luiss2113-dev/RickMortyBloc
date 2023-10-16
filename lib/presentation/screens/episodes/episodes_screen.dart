import 'package:rick_morty_app/presentation/screens/episodes/widget/widget.dart';
import 'package:rick_morty_app/presentation/blocs/episode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../global/widgets.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(child:
          BlocBuilder<EpisodeCubit, EpisodeState>(builder: (context, state) {
        if (state.isError) {
          return CustomError(
            errorDetails: FlutterErrorDetails(exception: state.error),
            onRefresh: () => context.read<EpisodeCubit>().loadEpisodes(),
          );
        }

        if (!state.isEmpty) {
          return const EpisodeRender();
        }

        return const CircularProgressIndicator(); //TODO: implement shimmer view
      })),
    );
  }
}
