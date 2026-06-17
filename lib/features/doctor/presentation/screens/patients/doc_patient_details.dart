import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/Diagnoses_history.dart';
import 'package:behind_silent_eyes/features/doctor/data/models/prediction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DocPatientDetails extends StatefulWidget {
  final Map<String, String> patient;
  const DocPatientDetails({super.key, required this.patient});

  @override
  State<DocPatientDetails> createState() => _DocPatientDetailsState();
}

class _DocPatientDetailsState extends State<DocPatientDetails> {
  @override
  void initState() {
    super.initState();
    final patientId = int.tryParse(widget.patient['id'] ?? '');
    if (patientId != null) {
      context.read<DoctorCubit>().getHistory(patientId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.patient;

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
          'Patient Details',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Profile header ──────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.accentLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_rounded,
                        color: AppColors.accent, size: 38),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    p['name'] ?? '—',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'PATIENT',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Info section ─────────────────────────────────────────
            _sectionLabel('Personal Information'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _infoTile(
                    icon: Icons.badge_outlined,
                    label: 'National ID',
                    value: p['national_id'] ?? '—',
                  ),
                  _divider(),
                  _infoTile(
                    icon: Icons.cake_outlined,
                    label: 'Date of Birth',
                    value: p['date_of_birth'] ?? '—',
                  ),
                  _divider(),
                  _infoTile(
                    icon: Icons.wc_rounded,
                    label: 'Gender',
                    value: _capitalize(p['gender'] ?? '—'),
                  ),
                  _divider(),
                  _infoTile(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: (p['phone']?.isEmpty ?? true) ? '—' : p['phone']!,
                  ),
                  _divider(),
                  _infoTile(
                    icon: Icons.calendar_month_outlined,
                    label: 'Registered On',
                    value: p['registered_on'] ?? '—',
                  ),
                  _divider(),
                  _infoTile(
                    icon: Icons.medical_information_outlined,
                    label: 'Medical History',
                    value: (p['medical_history']?.isEmpty ?? true)
                        ? '—'
                        : p['medical_history']!,
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Diagnoses section ────────────────────────────────────
            _sectionLabel('Latest Diagnosis'),
            const SizedBox(height: 8),

            BlocBuilder<DoctorCubit, DoctorState>(
              builder: (context, state) {
                if (state is DoctorLoading) {
                  return Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.accent),
                    ),
                  );
                }

                if (state is DoctorFailure) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.dangerBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                    ),
                    child: Text(state.message,
                        style: GoogleFonts.poppins(
                            color: AppColors.danger, fontSize: 13)),
                  );
                }

                if (state is HistoryLoaded) {
                  if (state.predictions.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 28, horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(Icons.history_rounded,
                                color: AppColors.textHint, size: 36),
                            const SizedBox(height: 8),
                            Text('No diagnoses yet',
                                style: GoogleFonts.poppins(
                                    color: AppColors.textSecondary,
                                    fontSize: 14)),
                          ],
                        ),
                      ),
                    );
                  }

                  final latest =
                  state.predictions.first as PredictionModel;

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _infoTile(
                          icon: Icons.biotech_rounded,
                          label: 'Disease Type',
                          value: latest.diseaseType,
                        ),
                        _divider(),
                        _infoTile(
                          icon: Icons.calendar_today_rounded,
                          label: 'Date',
                          value: latest.createdAt ?? '—',
                        ),
                        _divider(),
                        _infoTile(
                          icon: Icons.warning_amber_rounded,
                          label: 'Severity',
                          value: latest.severity ?? '—',
                        ),
                        _divider(),
                        _infoTile(
                          icon: Icons.percent_rounded,
                          label: 'Confidence',
                          value: latest.confidencePercent,
                          isLast: true,
                        ),

                        // View All link
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.border),
                            ),
                          ),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DiagnosesHistory(
                                    patient: widget.patient),
                              ),
                            ),
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(14)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14),
                              child: Center(
                                child: Text(
                                  'View all (${state.predictions.length})',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(
                    child: Text('Loading diagnoses...',
                        style: GoogleFonts.poppins(
                            color: AppColors.textSecondary, fontSize: 13)),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────
  Widget _sectionLabel(String text) => Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      letterSpacing: 0.3,
    ),
  );

  Widget _divider() => const Divider(
      height: 1, thickness: 1, indent: 56, color: AppColors.border);

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 14,
        bottom: isLast ? 14 : 10,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: AppColors.accent, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 1),
                Text(value,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}