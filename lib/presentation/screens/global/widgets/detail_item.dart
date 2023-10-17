
import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const DetailItem({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: Icon(
            icon,
            size: 40,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
          ),
          subtitle: Text(subtitle,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  )),
        ),
      ),
    );
  }
}
