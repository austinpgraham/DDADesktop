import 'package:dda_desktop/presentation/router.dart';
import 'package:flutter/material.dart';

class DDAApp extends StatelessWidget {
  const DDAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MaterialApp.router(
        theme: ThemeData(), // TODO! Need a theme.
        routerConfig: rootRouter,
      ),
    );
  }
}
