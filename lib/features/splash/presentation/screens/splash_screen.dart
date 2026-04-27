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
    // أولاً نشوف لو في user token (doctor/admin)
    final token    = await LocalStorage.getToken();
    final userJson = await LocalStorage.getUser();

    if (token != null && userJson != null) {
      final user = UserModel.fromJsonString(userJson);
      if (user.isAdmin)  return AdminDashboard();
      if (user.isDoctor) return DocDashboard();
    }

    // ثانياً نشوف لو في patient token
    final patientToken = await LocalStorage.getPatientToken();
    final patientJson  = await LocalStorage.getPatient();

    if (patientToken != null && patientJson != null) {
      final patient = PatientModel.fromJsonString(patientJson);
      return PatientDashboard(patient: {
        'id':          patient.id.toString(),
        'name':        patient.name,
        'age':         patient.age.toString(),
        'gender':      patient.gender,
        'national_id': patient.nationalId,
        'phone':       patient.phone ?? '',
      });
    }

    // مفيش حاجة → Login
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: ZoomIn(
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
            child: Center(child: Image.asset('assets/images/logo.png')),
          ),
        ),
      ),
    );
  }
}