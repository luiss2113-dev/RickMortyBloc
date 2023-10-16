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
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Card(
        shape: const CircleBorder(),
        elevation: 10,
        child: Container(
          width: media.width * width,
          height: media.height * height,
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(url),
          ),
        ),
      ),
    );
  }
}
