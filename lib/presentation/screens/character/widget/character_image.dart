import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  final double height;
  final double width;
  final String url;
  const CharacterImage({
    super.key,
    required this.url,
    this.height = 0.18,
    this.width = 0.30,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

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
              url,
            ),
          ),
        ),
      ),
    );
  }
}
