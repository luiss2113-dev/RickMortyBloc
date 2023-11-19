import 'package:flutter/material.dart';
import '../../../../domain/models/models.dart';

class CharacterInherited extends InheritedWidget {
  const CharacterInherited(
      {super.key, required Widget child, required this.character})
      : super(child: child);

  final CharacterItemModel character;

  static CharacterInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CharacterInherited>();
  }

  @override
  bool updateShouldNotify(CharacterInherited oldWidget) {
    return oldWidget.character != character;
  }
}
