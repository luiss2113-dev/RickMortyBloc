import 'widget.dart';
import 'package:rick_morty_app/domain/models/models.dart';
import 'package:flutter/material.dart';

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
      child: CharacterInherited(
        character: character,
        child: const Stack(
          children: [
            Align(alignment: Alignment.bottomRight, child: CharacterContent()),
            Align(alignment: Alignment.centerLeft, child: CharacterImage()),
          ],
        ),
      ),
    );
  }
}
