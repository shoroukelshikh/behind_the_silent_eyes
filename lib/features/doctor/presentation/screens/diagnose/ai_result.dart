import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AiResult extends StatelessWidget {
  final Map<String, dynamic>? diagnose;
  final Map<String, String>?  patient;

  const AiResult({super.key, this.diagnose, this.patient});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return BlocListener<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is ReportGenerated) {
          // افتح الـ PDF في المتصفح
          launchUrl(Uri.parse(state.fileUrl),
              mode: LaunchMode.externalApplication);
        }
        if (state is DoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('AI Diagnosis Result',
              style: GoogleFonts.poppins(
                  color: const Color(0xff5E5757),
                  fontWeight: FontWeight.w500)),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.primary),
          child: Padding(
            padding: EdgeInsets.all(h * 0.01),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.1),
                  Center(
                    child: Image.asset(
                        'assets/images/Central-Retinal-Artery-Occlusion 1.png'),
                  ),
                  Text('Diagnoses result',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff5E5757),
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  SizedBox(height: h * 0.02),
                  // ── Diagnose Card ──────────────────────────────
                  Center(
                    child: Container(
                      width: w * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(h * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _resultRow('Diagnosis', diagnose?['disease'] ?? '-'),
                          SizedBox(height: h * 0.02),
                          _resultRow('Severity level', diagnose?['severity'] ?? '-'),
                          SizedBox(height: h * 0.02),
                          _resultRow('Confidence', diagnose?['confidence'] ?? '-'),
                          SizedBox(height: h * 0.02),
                          _resultRow('Date', diagnose?['date'] ?? '-'),
                          SizedBox(height: h * 0.02),
                          _resultRow('Status', diagnose?['status'] ?? '-'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Text('Patient information',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff5E5757),
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  SizedBox(height: h * 0.02),
                  // ── Patient Card ───────────────────────────────
                  Center(
                    child: Container(
                      width: w * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(h * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _resultRow('Name',   patient?['name']   ?? '-'),
                          SizedBox(height: h * 0.02),
                          _resultRow('Age',    patient?['age']    ?? '-'),
                          SizedBox(height: h * 0.02),
                          _resultRow('Gender', patient?['gender'] ?? '-'),
                          SizedBox(height: h * 0.03),
                          // ── Download Report ────────────────────
                          Center(
                            child: BlocBuilder<DoctorCubit, DoctorState>(
                              builder: (context, state) {
                                return state is DoctorLoading
                                    ? const CircularProgressIndicator()
                                    : InkWell(
                                  onTap: () {
                                    final id = diagnose?['id'];
                                    if (id != null) {
                                      context
                                          .read<DoctorCubit>()
                                          .generateReport(id);
                                    }
                                  },
                                  child: Text(
                                    'Download report',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff162BE8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      decoration:
                                      TextDecoration.underline,
                                      decorationThickness: 3,
                                      decorationColor:
                                      const Color(0xff162BE8),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: h * 0.04),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(color: Colors.grey)),
        Text(value,
            style: GoogleFonts.poppins(
                color: const Color(0xff5E5757),
                fontSize: 16,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}