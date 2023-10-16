import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const DescriptionItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w800, fontSize: 30)),
      subtitle: Text(subtitle,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20
              )),
      leading: Icon(
        icon,
        size: 40,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
