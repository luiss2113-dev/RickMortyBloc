import 'package:flutter/material.dart';
import '../../global/widgets.dart' show HeaderWidgets;

class ResponseBody extends StatefulWidget {
  final VoidCallback action;
  final String title;
  final Widget child;

  const ResponseBody({
    required this.action,
    required this.title,
    required this.child,
    super.key,
  });

  @override
  State<ResponseBody> createState() => _ResponseBodyState();
}

class _ResponseBodyState extends State<ResponseBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      widget.action();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: HeaderWidgets(title: widget.title),
        ),
        widget.child
      ],
    );
  }
}
