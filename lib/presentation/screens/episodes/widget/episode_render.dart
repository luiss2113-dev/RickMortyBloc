import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/presentation/blocs/blocs.dart';

import '../../global/widgets.dart';
import 'widget.dart';

class EpisodeRender extends StatefulWidget {
  const EpisodeRender({
    super.key,
  });

  @override
  State<EpisodeRender> createState() => _EpisodeRenderState();
}

class _EpisodeRenderState extends State<EpisodeRender> {
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
      context.read<EpisodeCubit>().fetchMoreLocations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const HeaderWidgets(title: 'Episodios'),
      Expanded(
        child: BlocConsumer<EpisodeCubit, EpisodeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.episodes.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return TitleItem(
                    title: state.episodes[index].episodeName,
                    sutitle: state.episodes[index].episode,
                    onTap: () => modalDetailsContent(
                          context: context,
                          child: EpisodeDetail(
                            episode: state.episodes[index],
                          ),
                        ));
              },
            );
          },
        ),
      )
    ]);
  }
}
