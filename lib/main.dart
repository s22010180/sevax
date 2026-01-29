import 'package:flutter/material.dart';
import 'screens/main_wrapper.dart'; // Make sure the path is correct

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
      // The 'home' property defines the first screen the user sees after the Splash
      home: const MainWrapper(), 
    );
  }
}

