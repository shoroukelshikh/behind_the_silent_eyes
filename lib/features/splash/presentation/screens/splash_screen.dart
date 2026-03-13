import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Starting point of the gradient
            end: Alignment.bottomCenter, // Ending point of the gradient
            colors: [
              Color(0xFFB4E5F2), // Light blue
              Color(0xFF68848C), // Darker blue/teal
            ],
          ),
        ),
        child: ZoomIn(
          duration: Duration(seconds: 2),
          child: FadeIn(
            duration: Duration(seconds: 2),
            child: Center(child: Image.asset('assets/images/logo.png')),
          ),
        ),
      ),
    );
  }
}
