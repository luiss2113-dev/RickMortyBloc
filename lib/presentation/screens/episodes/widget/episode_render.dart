import '../../global/widgets/response_body.dart';
import 'widget.dart';
import 'package:rick_morty_app/presentation/blocs/blocs.dart'
    show EpisodeState, EpisodeBloc, GetEpisodeEvent;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import '../../global/widgets.dart' show modalDetailsContent, TitleItem;

class EpisodeContainer extends StatelessWidget {
  const EpisodeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponseBody(
      action: () => context.read<EpisodeBloc>().add(const GetEpisodeEvent()),
      title: 'Episodios',
      child: const ListBodyEpisode(),
    );
  }
}

class ListBodyEpisode extends StatelessWidget {
  const ListBodyEpisode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeBloc, EpisodeState>(
      buildWhen: (previous, current) => previous.episodes != current.episodes,
      builder: (context, state) {
        final episodesList = state.episodes.results;
        return SliverList.builder(
          itemCount: episodesList!.length,
          itemBuilder: (context, index) {
            return TitleItem(
              title: episodesList[index].episodeName,
              sutitle: episodesList[index].episode,
              onTap: () => modalDetailsContent(
                context: context,
                child: EpisodeDetail(
                  episode: episodesList[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
