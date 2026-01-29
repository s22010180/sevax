import 'package:flutter/material.dart';
import 'screens/main_wrapper.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SevaX());
}

class SevaX extends StatelessWidget {
  const SevaX({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SevaX',
      home: const SplashScreen(), 
    );
  }
}

