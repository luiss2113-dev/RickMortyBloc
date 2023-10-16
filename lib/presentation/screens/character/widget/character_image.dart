import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  final String url;
  const CharacterImage({
    super.key,
    required this.url,
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
          width: media.width * 0.30,
          height: media.height * 0.18,
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(url),
          ),
        ),
      ),
    );
  }
}
