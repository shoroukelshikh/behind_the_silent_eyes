import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_state.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/forget_pass.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/patient_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../admin/presentation/screens/dashboard/admin_dashboard.dart';
import '../../../admin/presentation/widgets/text_field.dart';
import '../../../doctor/presentation/screens/dashboard/doc_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          if (state.user.isDoctor) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DocDashboard()),
            );
          } else if (state.user.isAdmin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AdminDashboard()),
            );
          }
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
                          'Sign in',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Welcome back. Enter your credentials to continue.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                label: 'Email address',
                                hintText: 'you@hospital.org',
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Email required';
                                  if (!value.contains('@')) return 'Enter a valid email';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'Password',
                                hintText: '••••••••',
                                controller: passwordController,
                                obscureText: isPasswordHidden,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () => setState(
                                          () => isPasswordHidden = !isPasswordHidden),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Password required';
                                  if (value.length < 6) return 'Min 6 characters';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ForgetPass()),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.accent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                    context.read<AuthCubit>().login(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
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
                        // ── Divider ──────────────────────────────
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
                              'Are you a patient? ',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const PatientLoginScreen()),
                              ),
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