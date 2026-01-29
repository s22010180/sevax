import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SevaX());
}

class SevaX extends StatelessWidget {
  const SevaX({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SevaX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6200EE)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

