import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/domain/models/character_item_model.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/presentation/blocs/character_bloc.dart';
import 'character_item.dart';
import '../../global/widgets.dart';

class CharacterRender extends StatefulWidget {
  final List<CharacterItemModel> characters;
  final Function onfechMore;
  const CharacterRender(
      {super.key, required this.characters, required this.onfechMore});

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
      widget.onfechMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const CustomTitle(
        title: 'Personajes',
      ),
      Expanded(
        child: ListView.builder(
          itemCount: widget.characters.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return CharacterItem(
              character: widget.characters[index],
              onSelected: () {
                context
                    .read<CharacterCubit>()
                    .setSelectedCharacter(widget.characters[index]);
              },
            );
          },
        ),
      )
    ]);
  }
}
