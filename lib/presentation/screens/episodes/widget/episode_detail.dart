import 'package:flutter/material.dart';
import '../../global/widgets.dart'
    show DetailContainer, CustomTitle, DetailItem;
import '../../../../domain/models/models.dart' show EpisodeItemModel;

class EpisodeDetail extends StatelessWidget {
  final EpisodeItemModel _episode;
  const EpisodeDetail({
    super.key,
    required EpisodeItemModel episode,
  }) : _episode = episode;

  @override
  Widget build(BuildContext context) {
    return DetailContainer(
        child: Column(
      children: [
        CustomTitle(title: _episode.episodeName),
        ...buildContentDetail(
          ctx: context,
          episode: _episode,
        )
      ],
    ));
  }
}

List<Widget> buildContentDetail({
  required BuildContext ctx,
  required EpisodeItemModel episode,
}) {
  return [
    DetailItem(
      icon: Icons.live_tv,
      title: 'Episodio:',
      subtitle: episode.episode,
    ),
    DetailItem(
      icon: Icons.airplay_outlined,
      title: 'Al aire en:',
      subtitle: episode.airDate,
    ),
    DetailItem(
      icon: Icons.format_align_center_sharp,
      title: '# Personajes:',
      subtitle: "${episode.countCharacters} actores",
    ),
  ];
}
