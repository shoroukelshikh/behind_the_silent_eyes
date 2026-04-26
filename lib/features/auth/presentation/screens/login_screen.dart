import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/forget_pass.dart';
import 'package:behind_silent_eyes/features/auth/presentation/screens/patient_login.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.24,
                height: MediaQuery.of(context).size.width * 0.24,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffDAE0E8FF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white70),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff665F5F),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'Email',
                            hintText: 'Enter your email',
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Email required';
                              if (!value.contains('@'))
                                return 'Enter valid email';
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.012,
                          ),
                          CustomTextField(
                            label: 'password',
                            hintText: 'please enter password',
                            controller: passwordController,
                            obscureText: isPasswordHidden,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password required';
                              }
                              if (value.length < 6) return 'Min 6 chars';
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPass(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot password ?",
                          style: GoogleFonts.poppins(
                            color: Color(0xff0400FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff474161),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (emailController.text == "doctor@gmail.com") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DocDashboard(),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminDashboard(),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'patient?',
                          style: GoogleFonts.poppins(color: Color(0xff474161),fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PatientLoginScreen(),));
                          },
                          child: Text(
                            'login',
                            style: GoogleFonts.poppins(
                              color: Color(0xff0400FF),
                              fontWeight: FontWeight.bold,
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
    );
  }
}
