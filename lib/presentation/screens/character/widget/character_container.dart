import 'widget.dart';
import 'package:rick_morty_app/presentation/blocs/blocs.dart';
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
      context.read<CharacterCubit>().fetchMoreCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const HeaderWidgets(title: 'Personajes'),
      Expanded(
        child: BlocConsumer<CharacterCubit, CharacterState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.characters.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return CharacterItem(
                  character: state.characters[index],
                );
              },
            );
          },
        ),
      )
    ]);
  }
}
