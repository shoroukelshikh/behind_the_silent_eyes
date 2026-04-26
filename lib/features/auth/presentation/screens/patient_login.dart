import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../admin/presentation/widgets/text_field.dart';
import '../../../patient/presentation/screens/patinet_dashboard.dart';

class PatientLoginScreen extends StatefulWidget {

  const PatientLoginScreen({super.key});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  final TextEditingController nationalIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                decoration: BoxDecoration(
                  color: const Color(0xffDAE0E8FF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white70),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Patient Login",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff665F5F),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    Form(
                      key: _formKey,
                      child: CustomTextField(
                        label: 'National ID',
                        hintText: 'Enter your national ID',
                        controller: nationalIdController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'National ID is required';
                          }
                          if (value.length != 14) {
                            return 'National ID must be 14 digits';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'National ID must contain digits only';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientDashboard(patient: {
                                  "name": "Ahmed Ali",
                                  "national_id": "2980 3151 2345 67",
                                  "age": "55",
                                  "date_of_birth": "15/03/1998",
                                  "gender": "Male",
                                  "medical_history": "Diabetes, Hypertension",
                                  "registered_on": "2/9/2025",
                                },),
                              ),
                            );
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.018),
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