import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessNewPass extends StatelessWidget {
  const SuccessNewPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // ── Success icon ──────────────────────────────────
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.successBg,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check_rounded,
                      color: AppColors.success, size: 52),
                ),
              ),
              const SizedBox(height: 28),

              Text(
                'Password updated!',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your password has been reset successfully.\nYou can now sign in with your new password.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),

              const Spacer(flex: 3),

              CustomButton(
                text: 'Back to sign in',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                size: 15,
                weight: FontWeight.w600,
                width: double.infinity,
                height: 50,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}