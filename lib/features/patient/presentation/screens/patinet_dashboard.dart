import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/domain/entities/patient_entity.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:behind_silent_eyes/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:behind_silent_eyes/features/patient/presentation/cubit/patient_state.dart';
import 'package:behind_silent_eyes/features/patient/presentation/screens/patient_diagnoses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../admin/presentation/widgets/gradient_card.dart';

class PatientDashboard extends StatefulWidget {
  final PatientEntity patient;
  const PatientDashboard({super.key, required this.patient});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  void initState() {
    super.initState();
    context.read<PatientCubit>().getProfile();
    context.read<PatientCubit>().getDiagnoses();
  }

  @override
  Widget build(BuildContext context) {
    final double width  = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Logout',
            onPressed: () async {
              await context.read<AuthCubit>().patientLogout();
              if (context.mounted) {
                Navigator.of(context).popUntil((r) => r.isFirst);
              }
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: BlocBuilder<PatientCubit, PatientState>(
          builder: (context, state) {
            final PatientEntity patient = state.patient ?? widget.patient;

            return SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: height * 0.12, bottom: height * 0.04),
              child: Column(
                children: [
                  // ── Profile Card ────────────────────────────
                  GradientCard(
                    width: width * .88,
                    children: [
                      _cardHeader(width, height, Icons.person, patient.name),
                      _divider(width),

                      if (state.isLoadingProfile)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.03),
                          child: const Center(child: CircularProgressIndicator()),
                        )
                      else if (state.profileError != null)
                        Padding(
                          padding: EdgeInsets.all(width * 0.04),
                          child: Column(
                            children: [
                              Text(state.profileError!,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white70)),
                              TextButton(
                                onPressed: () =>
                                    context.read<PatientCubit>().getProfile(),
                                child: const Text('Retry',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      else ...[
                          _infoRow(width, height,
                              icon: const Icon(Icons.badge_outlined,
                                  color: Colors.white, size: 24),
                              label: 'National ID',
                              value: patient.nationalId),
                          _infoRow(width, height,
                              icon: const Icon(Icons.cake_outlined,
                                  color: Colors.white, size: 24),
                              label: 'Date of Birth',
                              value: patient.dateOfBirth ?? '-'),
                          _infoRow(width, height,
                              icon: const Icon(Icons.transgender,
                                  color: Colors.white, size: 24),
                              label: 'Gender',
                              value: patient.gender),
                          _infoRow(width, height,
                              icon: const Icon(Icons.phone_outlined,
                                  color: Colors.white, size: 24),
                              label: 'Phone',
                              value: patient.phone ?? '-'),
                          _infoRow(width, height,
                              icon: const Icon(Icons.calendar_today_outlined,
                                  color: Colors.white, size: 24),
                              label: 'Registered On',
                              value: patient.registeredOn ?? '-'),
                          if (patient.medicalHistory != null &&
                              patient.medicalHistory!.isNotEmpty)
                            _infoRow(width, height,
                                icon: const Icon(
                                    Icons.medical_information_outlined,
                                    color: Colors.white,
                                    size: 24),
                                label: 'Medical History',
                                value: patient.medicalHistory!),
                        ],

                      SizedBox(height: height * .015),
                    ],
                  ),

                  SizedBox(height: height * 0.022),

                  // ── Diagnoses Preview Card ───────────────────
                  GradientCard(
                    width: width * .88,
                    children: [
                      _cardHeader(
                          width, height, Icons.history, 'Diagnoses History'),
                      _divider(width),

                      if (state.isLoadingDiagnoses)
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: height * 0.03),
                          child: const Center(
                              child: CircularProgressIndicator()),
                        )
                      else if (state.diagnosesError != null)
                        Padding(
                          padding: EdgeInsets.all(width * 0.04),
                          child: Column(
                            children: [
                              Text(state.diagnosesError!,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white70)),
                              TextButton(
                                onPressed: () =>
                                    context.read<PatientCubit>().getDiagnoses(),
                                child: const Text('Retry',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      else if (state.diagnoses != null) ...[
                          if (state.diagnoses!.isEmpty)
                            Padding(
                              padding: EdgeInsets.all(width * 0.04),
                              child: Text('No diagnoses yet.',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white70)),
                            )
                          else ...[
                            _previewRow(width, height, 'Disease type',
                                state.diagnoses!.first.diseaseType),
                            _previewRow(width, height, 'Date',
                                state.diagnoses!.first.createdAt ?? '-'),
                            _previewRow(width, height, 'Severity',
                                state.diagnoses!.first.severity ?? '-'),
                            _previewRow(width, height, 'Confidence',
                                state.diagnoses!.first.confidencePercent),
                            SizedBox(height: height * .015),
                            Center(
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PatientDiagnoses(patient: patient),
                                  ),
                                ),
                                child: Text(
                                  'view all',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],

                      SizedBox(height: height * .015),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────
  Widget _cardHeader(double w, double h, IconData icon, String title) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.018),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: w * 0.02),
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _divider(double w) =>
      Divider(thickness: w * .003, color: const Color(0x66ffffff));

  Widget _infoRow(double w, double h,
      {required Widget icon,
        required String label,
        required String value}) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.05, bottom: h * 0.018),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(width: w * .04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: const Color(0x99ffffff))),
              SizedBox(
                width: w * 0.65,
                child: Text(value,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    softWrap: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _previewRow(double w, double h, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.05, bottom: h * 0.012),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 14, color: const Color(0x99ffffff))),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }
}