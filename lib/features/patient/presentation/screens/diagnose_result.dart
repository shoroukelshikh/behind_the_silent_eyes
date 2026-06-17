import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/domain/entities/patient_entity.dart';
import 'package:behind_silent_eyes/features/patient/domain/entities/diagnose_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagnoseResult extends StatelessWidget {
  final DiagnoseEntity diagnose;
  final PatientEntity patient;

  const DiagnoseResult({
    super.key,
    required this.diagnose,
    required this.patient,
  });

  Color _severityColor(String? severity) {
    if (severity == null) return AppColors.textSecondary;
    final s = severity.toLowerCase();
    if (s.contains('severe') || s.contains('high')) return AppColors.danger;
    if (s.contains('moderate') || s.contains('medium')) return AppColors.warning;
    if (s.contains('mild') || s.contains('low')) return AppColors.success;
    return AppColors.textSecondary;
  }

  Color _severityBg(String? severity) {
    if (severity == null) return AppColors.background;
    final s = severity.toLowerCase();
    if (s.contains('severe') || s.contains('high')) return AppColors.dangerBg;
    if (s.contains('moderate') || s.contains('medium')) return AppColors.warningBg;
    if (s.contains('mild') || s.contains('low')) return AppColors.successBg;
    return AppColors.background;
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
          'Diagnosis result',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Retinal image ─────────────────────────────────────
            Center(
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                clipBehavior: Clip.hardEdge,
                child: diagnose.imagePath != null &&
                    diagnose.imagePath!.isNotEmpty
                    ? Image.network(
                  diagnose.imagePath!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _placeholder(),
                )
                    : _placeholder(),
              ),
            ),
            const SizedBox(height: 20),

            // ── Severity badge ────────────────────────────────────
            if (diagnose.severity != null)
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: _severityBg(diagnose.severity),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle,
                            size: 8,
                            color: _severityColor(diagnose.severity)),
                        const SizedBox(width: 6),
                        Text(
                          diagnose.severity!,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _severityColor(diagnose.severity),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (diagnose.severity != null) const SizedBox(height: 16),

            // ── Diagnosis result card ─────────────────────────────
            _SectionCard(
              title: 'Diagnosis result',
              icon: Icons.biotech_rounded,
              rows: [
                _RowData(label: 'Disease', value: diagnose.diseaseType),
                _RowData(
                    label: 'Confidence',
                    value: diagnose.confidencePercent),
                _RowData(label: 'Status', value: diagnose.status),
                _RowData(
                    label: 'Date', value: diagnose.createdAt ?? '-'),
                if (diagnose.notes != null && diagnose.notes!.isNotEmpty)
                  _RowData(label: 'Notes', value: diagnose.notes!),
              ],
            ),

            const SizedBox(height: 16),

            // ── Patient info card ──────────────────────────────────
            _SectionCard(
              title: 'Patient information',
              icon: Icons.person_outline_rounded,
              rows: [
                _RowData(label: 'Name', value: patient.name),
                _RowData(label: 'Age', value: patient.age.toString()),
                _RowData(label: 'Gender', value: patient.gender),
                _RowData(
                    label: 'National ID', value: patient.nationalId),
                if (patient.phone != null && patient.phone!.isNotEmpty)
                  _RowData(label: 'Phone', value: patient.phone!),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.remove_red_eye_outlined,
                color: AppColors.textHint, size: 40),
            const SizedBox(height: 8),
            Text(
              'Retinal scan image',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Card ──────────────────────────────────────────────────
class _RowData {
  final String label;
  final String value;
  const _RowData({required this.label, required this.value});
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_RowData> rows;

  const _SectionCard(
      {required this.title, required this.icon, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.accent, size: 17),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          // Rows
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              children: rows
                  .asMap()
                  .entries
                  .map((e) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value.label,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: Text(
                            e.value.value,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (e.key < rows.length - 1)
                    const Divider(
                        height: 1, color: AppColors.border),
                ],
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
