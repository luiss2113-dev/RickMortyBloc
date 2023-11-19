import 'widget.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/entities.dart';

class CharacterImage extends StatelessWidget {
  final double height;
  final double width;
  final String? url;
  const CharacterImage({
    super.key,
    this.url,
    this.height = 0.18,
    this.width = 0.30,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final CharacterEntity? character =
        CharacterInherited.of(context)?.character;

    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 10),
      child: Card(
        shape: const CircleBorder(),
        elevation: 10,
        child: SizedBox(
          width: media.width *
              (orientation == Orientation.portrait ? width : 0.10),
          height: media.height *
              (orientation == Orientation.portrait ? height : 0.60),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              character != null ? character.characterImage : '$url',
            ),
          ),
        ),
      ),
    );
  }
}
