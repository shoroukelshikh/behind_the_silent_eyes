import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_state.dart';
import 'package:behind_silent_eyes/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:behind_silent_eyes/features/patient/presentation/screens/patinet_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../admin/presentation/widgets/text_field.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({super.key});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  final TextEditingController nationalIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nationalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PatientAuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<PatientCubit>(),
                child: PatientDashboard(patient: state.patient),
              ),
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Logo ──────────────────────────────────────
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Behind Silent Eyes',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'AI-Powered Retinal Diagnostics',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // ── Card ──────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient sign in',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Enter your national ID to access your records.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          child: CustomTextField(
                            label: 'National ID',
                            hintText: 'Enter your 14-digit national ID',
                            controller: nationalIdController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'National ID is required';
                              if (value.length != 14)
                                return 'National ID must be 14 digits';
                              if (!RegExp(r'^\d+$').hasMatch(value))
                                return 'Digits only';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.navy,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().patientLogin(
                                      nationalId: nationalIdController
                                          .text
                                          .trim(),
                                    );
                                  }
                                },
                                child: state is AuthLoading
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Text(
                                  'Sign in',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(child: Divider(color: AppColors.border)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'or',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            const Expanded(child: Divider(color: AppColors.border)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not patient? ',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                'Sign in here',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
