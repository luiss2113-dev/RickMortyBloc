import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../global/widgets.dart';

class LocationDetail extends StatelessWidget {
  final LocationItemModel _location;
  const LocationDetail({super.key, required LocationItemModel location})
      : _location = location;

  @override
  Widget build(BuildContext context) {
    return DetailContainer(
      child: Column(
        children: [
          CustomTitle(
            title: _location.locationName,
          ),
          ...buildContentDetail(
            ctx: context,
            location: _location,
          ),
        ],
      ),
    );
  }
}

List<Widget> buildContentDetail(
    {required BuildContext ctx, required LocationItemModel location}) {
  return [
    DetailItem(
      icon: Icons.supervised_user_circle_outlined,
      title: 'Tipo:',
      subtitle: location.locationType,
    ),
    DetailItem(
      icon: Icons.supervised_user_circle_outlined,
      title: 'Dimensiones:',
      subtitle: "${location.dimension}",
    ),
    DetailItem(
      icon: Icons.location_city,
      title: 'N° Habitantes:',
      subtitle: "${location.countResidents}",
    ),
  ];
}
