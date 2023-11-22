import 'widget.dart' show CharacterInherited;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import '../../../../domain/entities/entities.dart' show CharacterEntity;

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
            backgroundImage: CachedNetworkImageProvider(
              character?.characterImage ?? '$url',
              cacheKey: character?.characterImage ?? '$url',
              errorListener: (p0) {
                () => const Icon(Icons.error);
              },
            ),
          ),
        ),
      ),
    );
  }
}
