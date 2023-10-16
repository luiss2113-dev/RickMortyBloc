import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import 'package:flutter/material.dart';
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
      context.read<LocationCubit>().fetchMoreLocations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const CustomTitle(
        title: 'Ubicaciones',
      ),
      Expanded(
        child: BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.locations.length, //locationCounter.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return TitleItem(
                  title: state.locations[index].locationName,
                  sutitle: state.locations[index].locationType,
                  icon: Icons.location_searching,
                  onTap: () {

                  },
                );
              },
            );
          },
        ),
      )
    ]);
  }
}
