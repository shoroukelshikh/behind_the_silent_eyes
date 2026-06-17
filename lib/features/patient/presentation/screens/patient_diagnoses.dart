import 'package:behind_silent_eyes/core/theme/colors.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Diagnoses history',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          // ── Loading ────────────────────────────────────────────
          if (state.isLoadingDiagnoses) {
            return const Center(
                child:
                CircularProgressIndicator(color: AppColors.accent));
          }

          // ── Error ──────────────────────────────────────────────
          if (state.diagnosesError != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.dangerBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error_outline_rounded,
                          color: AppColors.danger, size: 30),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.diagnosesError!,
                      style: GoogleFonts.poppins(
                          color: AppColors.textSecondary, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () =>
                          context.read<PatientCubit>().getDiagnoses(),
                      child: Text('Retry',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }

          // ── Empty ──────────────────────────────────────────────
          if (state.diagnoses == null || state.diagnoses!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.accentLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.history_rounded,
                        color: AppColors.accent, size: 34),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No diagnoses found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Your diagnosis history will appear here.',
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
            );
          }

          // ── Loaded ─────────────────────────────────────────────
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: state.diagnoses!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final DiagnoseEntity item = state.diagnoses![index];
              return _DiagnoseCard(
                diagnose: item,
                patient: widget.patient,
              );
            },
          );
        },
      ),
    );
  }
}

// ── Diagnose Card ──────────────────────────────────────────────────
class _DiagnoseCard extends StatelessWidget {
  final DiagnoseEntity diagnose;
  final PatientEntity patient;

  const _DiagnoseCard({required this.diagnose, required this.patient});

  Color _severityColor(String? severity) {
    if (severity == null) return AppColors.textSecondary;
    final s = severity.toLowerCase();
    if (s.contains('severe') || s.contains('high')) return AppColors.danger;
    if (s.contains('moderate') || s.contains('medium'))
      return AppColors.warning;
    if (s.contains('mild') || s.contains('low')) return AppColors.success;
    return AppColors.textSecondary;
  }

  Color _severityBg(String? severity) {
    if (severity == null) return AppColors.background;
    final s = severity.toLowerCase();
    if (s.contains('severe') || s.contains('high')) return AppColors.dangerBg;
    if (s.contains('moderate') || s.contains('medium'))
      return AppColors.warningBg;
    if (s.contains('mild') || s.contains('low')) return AppColors.successBg;
    return AppColors.background;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Left icon ─────────────────────────────────────
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.remove_red_eye_outlined,
                  color: AppColors.accent, size: 20),
            ),
            const SizedBox(width: 14),

            // ── Info ──────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diagnose.diseaseType,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (diagnose.severity != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _severityBg(diagnose.severity),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            diagnose.severity!,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _severityColor(diagnose.severity),
                            ),
                          ),
                        ),
                      if (diagnose.severity != null)
                        const SizedBox(width: 8),
                      Text(
                        diagnose.confidencePercent,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diagnose.createdAt ?? '-',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),

            // ── View button ───────────────────────────────────
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DiagnoseResult(
                    diagnose: diagnose,
                    patient: patient,
                  ),
                ),
              ),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'View',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
