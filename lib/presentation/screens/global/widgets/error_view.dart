import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final Function onRefresh;
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final media = MediaQuery.of(context).size;

    return SizedBox(
      height: media.height,
      width: media.width,
      child: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/error_image.jpg'),
                Text(
                  kDebugMode
                      ? errorDetails.summary.toString()
                      : 'Oups! Something went wrong!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: kDebugMode ? Colors.red : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
                const SizedBox(height: 12),
                const Text(
                  "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
