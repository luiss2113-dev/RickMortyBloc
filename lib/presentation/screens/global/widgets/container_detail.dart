import 'package:flutter/material.dart';

class DetailContainer extends StatelessWidget {
  final Widget child;
  const DetailContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
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
          child
        ],
      ),
    );
  }
}
