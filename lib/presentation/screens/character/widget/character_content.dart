import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/entities/entities.dart';

import '../../../../utils/enums.dart';
import '../../global/widgets.dart';
import 'widget.dart';

class CharacterContent extends StatelessWidget {
  const CharacterContent({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: EdgeInsets.only(
          right: orientation == Orientation.landscape ? 20 : 10),
      child: SizedBox(
        width: orientation == Orientation.landscape
            ? media.width * 0.90
            : media.width * 0.74,
        height: media.height * 0.3,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              bodyContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding bodyContent(BuildContext context) {
    final CharacterEntity character = CharacterInherited.of(context)!.character;

    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                character.characterName,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 30,
                      overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 2,
              ),
              subtitle: Text(
                characterStatusValues.reverse[character.characterStatus]!,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          IconButton(
              onPressed: () => modalDetailsContent(
                  context: context,
                  child: CharacterDetail(
                    character: CharacterInherited.of(context)!.character,
                  )),
              icon: const Icon(Icons.navigate_next_sharp))
        ],
      ),
    );
  }
}
