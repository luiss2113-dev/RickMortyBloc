import 'package:flutter/material.dart';

class CharacterContent extends StatelessWidget {
  final String _title;
  final String _status;
  final Function _moreDetails;
  const CharacterContent({
    super.key,
    required String title,
    required String status,
    required Function moreDetails,
  })  : _title = title,
        _status = status,
        _moreDetails = moreDetails;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding:
          EdgeInsets.only(right: orientation == Orientation.landscape ? 20 : 10),
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
    return Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        _title,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                              fontSize: 30,
                              overflow: TextOverflow.ellipsis,
                            ),
                        maxLines: 2,
                      ),
                      subtitle: Text(
                        _status,
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () => _moreDetails(),
                      icon: const Icon(Icons.navigate_next_sharp))
                ],
              ),
            );
  }
}
