import 'package:flutter/material.dart';

class EpisodeInherited extends InheritedWidget {
  const EpisodeInherited({super.key, required Widget child})
      : super(child: child);

  static EpisodeInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EpisodeInherited>();
  }

  @override
  bool updateShouldNotify(EpisodeInherited oldWidget) {
    return true;
  }
}
