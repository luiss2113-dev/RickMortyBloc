import 'package:rick_morty_app/presentation/blocs/blocs.dart';

import 'widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global/widgets.dart';

class CharacterRender extends StatefulWidget {
  const CharacterRender({super.key});

  @override
  State<CharacterRender> createState() => _CharacterRenderState();
}

class _CharacterRenderState extends State<CharacterRender> {
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
      context.read<CharacterBloc>().add(const GetCharacterEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const HeaderWidgets(title: 'Personajes'),
      Expanded(
        child: BlocBuilder<CharacterBloc, CharacterState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            final characters = state.characters.results;
            return ListView.builder(
              itemCount: characters!.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return CharacterItem(
                  character: characters[index],
                );
              },
            );
          },
        ),
      )
    ]);
  }
}
