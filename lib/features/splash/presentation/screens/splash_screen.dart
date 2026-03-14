import 'package:animate_do/animate_do.dart';
import 'package:behind_silent_eyes/features/admin/dashboard/presentation/screens/admin_dashboard.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/screens/add_doc.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD6F3FA),
              Color(0xFFB4E5F2),
              Color(0xFF68848C),
            ],
          ),
        ),
        child: ZoomIn(
          duration: Duration(seconds: 2),
          child: FadeIn(
            duration: Duration(seconds: 2),
            onFinish: (controller) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminDashboard(),
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
