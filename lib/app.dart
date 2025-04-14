import 'package:dda_desktop/presentation/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DDAApp extends StatelessWidget {
  const DDAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0x001c2120),
        textTheme: TextTheme(
          bodySmall: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontFamily: "Poppins"
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: "OleoScript"
          )
        )
      ),
      routerConfig: rootRouter,
    );
  }
}
