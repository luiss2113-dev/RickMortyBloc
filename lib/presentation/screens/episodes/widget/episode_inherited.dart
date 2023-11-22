import 'package:flutter/material.dart';
import '../../../../domain/models/models.dart' show EpisodeItemModel;

class EpisodeInherited extends InheritedWidget {
  const EpisodeInherited(
      {super.key, required Widget child, required this.episodes})
      : super(child: child);

  final EpisodeItemModel episodes;

  static EpisodeInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EpisodeInherited>();
  }

  @override
  bool updateShouldNotify(EpisodeInherited oldWidget) {
    return oldWidget.episodes != episodes;
  }
}
