import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/reset_pass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendCode extends StatefulWidget {
  final String email;
  const SendCode({super.key, required this.email});

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  List<TextEditingController> controllers =
  List.generate(5, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (var c in controllers) c.dispose();
    for (var f in focusNodes) f.dispose();
    super.dispose();
  }

  String getCode() => controllers.map((e) => e.text).join();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // ── Back ──────────────────────────────────────────
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    color: AppColors.textPrimary, size: 20),
              ),
              const SizedBox(height: 32),

              // ── Icon ─────────────────────────────────────────
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(Icons.mark_email_read_outlined,
                      color: AppColors.accent, size: 26),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Check your email',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We sent a 5-digit code to ${widget.email}",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),

              // ── OTP fields ────────────────────────────────────
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return SizedBox(
                      width: (w - 56 - 40) / 5,
                      height: 56,
                      child: TextFormField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) return '';
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) return '';
                          return null;
                        },
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 4) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            }
                          } else {
                            if (index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index - 1]);
                            }
                          }
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.border, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.accent, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.danger, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.danger, width: 2),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 36),

              // ── Verify button ─────────────────────────────────
              SizedBox(
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPass()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter the full code'),
                          backgroundColor: AppColors.navy,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Verify code',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Resend ────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive it? ",
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Resend code',
                      style: GoogleFonts.poppins(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}