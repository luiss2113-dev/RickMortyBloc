import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:rick_morty_app/presentation/screens/locations/widget/widget.dart';

import '../../../blocs/blocs.dart';
import '../../global/widgets.dart';

class LocationContainer extends StatelessWidget {
  const LocationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponseBody(
      action: () =>
          context.read<LocationsBloc>().add(const GetLocationsEvent()),
      title: 'Ubicaciones',
      child: const ListBodyLocations(),
    );
  }
}

class ListBodyLocations extends StatelessWidget {
  const ListBodyLocations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      buildWhen: (previous, current) => previous.locations != current.locations,
      builder: (context, state) {
        final locations = state.locations.results;
        return SliverList.builder(
          itemCount: locations!.length,
          itemBuilder: (context, index) {
            return TitleItem(
              title: locations[index].locationName,
              sutitle: locations[index].locationType,
              icon: Icons.location_searching,
              onTap: () => modalDetailsContent(
                context: context,
                child: LocationDetail(
                  location: locations[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
