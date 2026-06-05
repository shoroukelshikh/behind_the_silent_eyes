// ── reset_pass.dart ───────────────────────────────────────────────
import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/success_newpass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../admin/presentation/widgets/text_field.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New password',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(Icons.lock_outline_rounded,
                        color: AppColors.accent, size: 26),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'Set a new password',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your new password must be at least 6 characters.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 36),

                CustomTextField(
                  label: 'New password',
                  hintText: 'Enter your new password',
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () =>
                        setState(() => isPasswordHidden = !isPasswordHidden),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password required';
                    if (value.length < 6) return 'Min 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirm password',
                  hintText: 'Re-enter your new password',
                  controller: repasswordController,
                  obscureText: isConfirmPasswordHidden,
                  suffixIcon: IconButton(
                    icon: Icon(isConfirmPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () => setState(() =>
                    isConfirmPasswordHidden = !isConfirmPasswordHidden),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please confirm your password';
                    if (value != passwordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 36),

                CustomButton(
                  height: 50,
                  width: double.infinity,
                  text: 'Update password',
                  size: 15,
                  weight: FontWeight.w600,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SuccessNewPass()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}