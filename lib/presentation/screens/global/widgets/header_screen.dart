import 'package:flutter/material.dart';
import '../widgets.dart';

class HeaderWidgets extends StatelessWidget {
  final String _title;
  const HeaderWidgets({
    super.key,
    required String title,
  }) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: CustomTitle(
              title: _title,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: IconButton(
              icon: const Icon(Icons.search, size: 35),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate());
              },
            ),
          ),
        )
      ],
    );
  }
}
