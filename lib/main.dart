import 'package:flutter/material.dart';

import 'screens/meditation_screens.dart';

void main() => runApp(const UiLayoutsApp());

class UiLayoutsApp extends StatelessWidget {
  const UiLayoutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Layouts',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0AA6A5)),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const WelcomeScreen(),
    );
  }
}
