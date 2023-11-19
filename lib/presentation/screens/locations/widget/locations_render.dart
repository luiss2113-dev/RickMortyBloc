import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/presentation/screens/locations/widget/widget.dart';

import '../../../blocs/blocs.dart';
import '../../global/widgets.dart';

class LocationRender extends StatefulWidget {
  const LocationRender({super.key});

  @override
  State<LocationRender> createState() => _LocationRenderState();
}

class _LocationRenderState extends State<LocationRender> {
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
      context.read<LocationsBloc>().add(const GetLocationsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const HeaderWidgets(title: 'Ubicaciones'),
      Expanded(
        child: BlocBuilder<LocationsBloc, LocationsState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            final locations = state.locations.results;
            return ListView.builder(
              itemCount: locations!.length,
              controller: _scrollController,
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
        ),
      )
    ]);
  }
}
