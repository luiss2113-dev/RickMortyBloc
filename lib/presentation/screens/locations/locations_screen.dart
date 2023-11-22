import 'widget/widget.dart' show LocationContainer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import '../global/widgets.dart' show CustomError;
import '../../blocs/blocs.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(
          child: BlocBuilder<LocationsBloc, LocationsState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                switch (state.state) {
                  case BlocState.error:
                    return CustomError(
                        errorDetails:
                            FlutterErrorDetails(exception: state.messageError),
                        onRefresh: () => context.read<LocationsBloc>()
                          ..add(const GetLocationsEvent()));
                  case BlocState.loaded:
                    return const LocationContainer();
                  default:
                    return const CircularProgressIndicator();
                }
              })),
    );
  }
}
