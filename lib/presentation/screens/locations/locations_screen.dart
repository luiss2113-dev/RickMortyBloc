import 'widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../global/widgets.dart';
import '../../blocs/blocs.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(
          child: BlocBuilder<LocationCubit, LocationState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state.isError) {
                  return CustomError(
                      errorDetails: FlutterErrorDetails(exception: state.error),
                      onRefresh: () =>
                          context.read<LocationCubit>()..fetchMoreLocations());
                }

                if (!state.isEmpty) {
                  return const LocationRender();
                }

                return const CircularProgressIndicator(); //TODO: implement shimmer view
              })),
    );
  }
}
