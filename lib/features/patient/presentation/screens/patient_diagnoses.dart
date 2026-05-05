import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/auth/domain/entities/patient_entity.dart';
import 'package:behind_silent_eyes/features/patient/domain/entities/diagnose_entity.dart';
import 'package:behind_silent_eyes/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:behind_silent_eyes/features/patient/presentation/cubit/patient_state.dart';
import 'package:behind_silent_eyes/features/patient/presentation/screens/diagnose_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientDiagnoses extends StatefulWidget {
  final PatientEntity patient;
  const PatientDiagnoses({super.key, required this.patient});

  @override
  State<PatientDiagnoses> createState() => _PatientDiagnosesState();
}

class _PatientDiagnosesState extends State<PatientDiagnoses> {
  @override
  void initState() {
    super.initState();
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
        title: Text(
          'Diagnoses History',
          style: GoogleFonts.poppins(
              fontSize: 18, color: const Color(0xff665F5F)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: BlocBuilder<PatientCubit, PatientState>(
          builder: (context, state) {

            // ── Loading ─────────────────────────────────────
            if (state.isLoadingDiagnoses) {
              return const Center(child: CircularProgressIndicator());
            }

            // ── Error ───────────────────────────────────────
            if (state.diagnosesError != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        color: Colors.white70, size: width * 0.15),
                    SizedBox(height: height * 0.02),
                    Text(state.diagnosesError!,
                        style: GoogleFonts.poppins(color: Colors.white70),
                        textAlign: TextAlign.center),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<PatientCubit>().getDiagnoses(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // ── Empty ───────────────────────────────────────
            if (state.diagnoses == null || state.diagnoses!.isEmpty) {
              return Center(
                child: Text(
                  'No diagnoses found.',
                  style: GoogleFonts.poppins(
                      color: Colors.white70, fontSize: 16),
                ),
              );
            }

            // ── Loaded ──────────────────────────────────────
            return ListView.builder(
              padding: EdgeInsets.only(
                top: height * 0.12,
                bottom: height * 0.02,
              ),
              itemCount: state.diagnoses!.length,
              itemBuilder: (context, index) {
                final DiagnoseEntity item = state.diagnoses![index];
                return _DiagnoseCard(
                  diagnose: item,
                  patient: widget.patient,
                  width: width,
                  height: height,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ── Diagnose Card ──────────────────────────────────────────────
class _DiagnoseCard extends StatelessWidget {
  final DiagnoseEntity diagnose;
  final PatientEntity  patient;
  final double width;
  final double height;

  const _DiagnoseCard({
    required this.diagnose,
    required this.patient,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LEFT: info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diagnose.diseaseType,
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.006),
                  _label('Severity',   diagnose.severity ?? '-'),
                  _label('Confidence', diagnose.confidencePercent),
                  _label('Date',       diagnose.createdAt ?? '-'),
                  _label('Status',     diagnose.status),
                ],
              ),
            ),
            // RIGHT: button
            CustomButton(
              text: 'View',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DiagnoseResult(
                    diagnose: diagnose,
                    patient: patient,
                  ),
                ),
              ),
              size: 13,
              weight: FontWeight.w500,
              width: width * 0.28,
              height: height * 0.042,
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String key, String value) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(color: Colors.black87, fontSize: 13),
        children: [
          TextSpan(
              text: '$key: ',
              style: const TextStyle(color: Colors.grey)),
          TextSpan(text: value),
        ],
      ),
    );
  }
}