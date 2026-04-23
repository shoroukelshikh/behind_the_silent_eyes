import 'package:animate_do/animate_do.dart';
import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primary,
        ),
        child: ZoomIn(
          duration: Duration(seconds: 2),
          child: FadeIn(
            duration: Duration(seconds: 2),
            onFinish: (controller) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Center(child: Image.asset('assets/images/logo.png')),
          ),
        ),
      ),
    );
  }
}
