import 'widget.dart';
import 'package:flutter/material.dart';
import '../../global/widgets.dart';
import '../../../../utils/enums.dart';
import '../../../../domain/models/models.dart';


class CharacterDetail extends StatelessWidget {
  final CharacterItemModel character;
  const CharacterDetail({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final renderItems = buildContentDetail(context, character);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, top: 5),
            width: media.width,
            alignment: Alignment.topLeft,
            child: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          Hero(
              transitionOnUserGestures: true,
              tag: character.tagHero,
              child: CharacterImage(
                url: character.characterImage,
              )),
          CustomTitle(title: character.characterName),
          ...renderItems,
        ],
      ),
    );
  }
}

List<Widget> buildContentDetail(
    BuildContext cox, CharacterItemModel character) {
  return [
    CharacterDetailItem(
      icon: character.status,
      title: 'Estado:',
      subtitle: characterStatusValues.reverse[character.characterStatus]!,
    ),
    CharacterDetailItem(
      icon: Icons.supervised_user_circle_outlined,
      title: 'Especie:',
      subtitle: character.especies,
    ),
    CharacterDetailItem(
      icon: character.status,
      title: 'Género:',
      subtitle: character.genre,
    ),
    CharacterDetailItem(
      icon: Icons.supervised_user_circle_outlined,
      title: 'Origen:',
      subtitle: character.origen,
    ),
    CharacterDetailItem(
      icon: Icons.location_city,
      title: 'Ubicación:',
      subtitle: character.origen,
    ),
    CharacterDetailItem(
      icon: Icons.live_tv_sharp,
      title: 'Episodios:',
      subtitle: '${character.episodeCount}',
    ),
  ];
}
