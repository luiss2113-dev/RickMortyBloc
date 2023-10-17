import 'package:flutter/material.dart';

void modalDetailsContent({
 required BuildContext context,
 required Widget child,
}) {
  final media = MediaQuery.of(context).size;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) {
      return FractionallySizedBox(
        heightFactor: 1,
        child: SizedBox(
          height: media.height,
          width: media.width,
          child: child,
        ),
      );
    },
  );
}
