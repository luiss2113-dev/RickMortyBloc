import 'package:flutter/material.dart';
import '../widgets.dart';

class TitleItem extends StatelessWidget {
  final String title, sutitle;
  final Function onTap;
  final IconData icon;
  const TitleItem(
      {super.key,
      required this.title,
      required this.sutitle,
      required this.onTap,
      this.icon = Icons.live_tv_rounded});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Row(
        children: <Widget>[
          Expanded(
            child: DescriptionItem(title: title, subtitle: sutitle, icon: icon),
          ),
          IconButton(
              onPressed: () => onTap(),
              icon: const Icon(Icons.navigate_next_sharp))
        ],
      ),
    );
  }
}
