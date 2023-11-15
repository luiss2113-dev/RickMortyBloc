import 'package:flutter/material.dart';

import 'package:rick_morty_app/domain/models/models.dart';

import '../../../../utils/enums.dart';
import '../../global/widgets.dart';
import 'widget.dart';

class CharacterItem extends StatelessWidget {
  final CharacterItemModel character;
  const CharacterItem({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width * .9,
      height: media.height * .2,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CharacterContent(
              title: character.characterName,
              status: characterStatusValues.reverse[character.characterStatus]!,
              moreDetails: () => modalDetailsContent(
                  context: context,
                  child: CharacterDetail(
                    character: character,
                  )),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: CharacterImage(url: character.characterImage)),
        ],
      ),
    );
  }
}
