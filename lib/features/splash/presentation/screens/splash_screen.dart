import 'package:animate_do/animate_do.dart';
import 'package:behind_silent_eyes/core/storage/local_storage.dart';
import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/data/models/patient_model.dart';
import 'package:behind_silent_eyes/features/auth/data/models/user_model.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/login_screen.dart';
import 'package:behind_silent_eyes/features/patient/presentation/screens/patinet_dashboard.dart';
import 'package:flutter/material.dart';

import '../../../admin/presentation/screens/dashboard/admin_dashboard.dart';
import '../../../doctor/presentation/screens/dashboard/doc_dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Widget> _getNextScreen() async {
    final token    = await LocalStorage.getToken();
    final userJson = await LocalStorage.getUser();

    if (token != null && token.isNotEmpty &&
        userJson != null && userJson.isNotEmpty) {
      final user = UserModel.fromJsonString(userJson);
      if (user.isAdmin)  return AdminDashboard();
      if (user.isDoctor) return DocDashboard();
    }

    final patientToken = await LocalStorage.getPatientToken();
    final patientJson  = await LocalStorage.getPatient();

    if (patientToken != null && patientToken.isNotEmpty &&
        patientJson  != null && patientJson.isNotEmpty) {
      final patient = PatientModel.fromJsonString(patientJson);
      return PatientDashboard(patient: patient);
    }

    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: ZoomIn(
        duration: const Duration(seconds: 2),
        child: FadeIn(
          duration: const Duration(seconds: 2),
          onFinish: (_) async {
            final nextScreen = await _getNextScreen();
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => nextScreen),
              );
            }
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Behind Silent Eyes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'AI-Powered Retinal Diagnostics',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}