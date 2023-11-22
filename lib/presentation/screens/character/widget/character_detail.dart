import 'package:flutter/material.dart';
import './widget.dart' show CharacterImage;
import '../../global/widgets.dart'
    show DetailContainer, CustomTitle, DetailItem;
import '../../../../utils/enums.dart' show characterStatusValues;
import '../../../../domain/models/models.dart' show CharacterItemModel;

class CharacterDetail extends StatelessWidget {
  final CharacterItemModel character;
  const CharacterDetail({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final renderItems = buildContentDetail(cox: context, character: character);
    return DetailContainer(
      child: Column(
        children: [
          CharacterImage(
            url: character.characterImage,
          ),
          CustomTitle(
            title: character.characterName,
          ),
          ...renderItems,
        ],
      ),
    );
  }
}

List<Widget> buildContentDetail({
  required BuildContext cox,
  required CharacterItemModel character,
}) {
  return [
    DetailItem(
      icon: character.status,
      title: 'Estado:',
      subtitle: characterStatusValues.reverse[character.characterStatus]!,
    ),
    DetailItem(
      icon: Icons.supervised_user_circle_outlined,
      title: 'Especie:',
      subtitle: character.especies,
    ),
    DetailItem(
      icon: character.status,
      title: 'Género:',
      subtitle: character.genre,
    ),
    DetailItem(
      icon: Icons.supervised_user_circle_outlined,
      title: 'Origen:',
      subtitle: character.origen,
    ),
    DetailItem(
      icon: Icons.location_city,
      title: 'Ubicación:',
      subtitle: character.origen,
    ),
    DetailItem(
      icon: Icons.live_tv_sharp,
      title: 'Episodios:',
      subtitle: '${character.episodeCount}',
    ),
  ];
}
