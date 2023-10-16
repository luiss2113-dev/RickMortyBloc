import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final bool isSelected;
  const MyIcon(
      {super.key, required this.icon, this.size = 22, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
      size: size,
    );
  }
}
