import 'package:flutter/material.dart';
import 'package:rick_morty_app/presentation/routes/routes.dart';
import 'package:rick_morty_app/presentation/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeApp,
      onGenerateRoute: (settings) => Routes.routes(settings),
    );
  }
}
