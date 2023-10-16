import 'package:flutter/material.dart';
import 'character_image.dart';
import 'character_content.dart';
import '../../../../utils/enums.dart';
import '../../../../domain/entities/character_entity.dart';

class CharacterItem extends StatelessWidget {
  final CharacterEntity character;
  final Function onSelected;
  const CharacterItem({
    super.key,
    required this.character,
    required this.onSelected,
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
              moreDetails: () => onSelected(),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Hero(
                  tag: character.tagHero,
                  child: CharacterImage(url: character.characterImage))),
        ],
      ),
    );
  }
}
