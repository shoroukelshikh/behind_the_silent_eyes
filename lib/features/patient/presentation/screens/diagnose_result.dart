import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/domain/entities/patient_entity.dart';
import 'package:behind_silent_eyes/features/patient/domain/entities/diagnose_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagnoseResult extends StatelessWidget {
  final DiagnoseEntity diagnose;
  final PatientEntity  patient;

  const DiagnoseResult({
    super.key,
    required this.diagnose,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'AI Diagnosis Result',
          style: GoogleFonts.poppins(
              color: const Color(0xff5E5757), fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: w * 0.05, vertical: h * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Eye image (retinal scan placeholder) ──────────
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: diagnose.imagePath != null &&
                      diagnose.imagePath!.isNotEmpty
                      ? Image.network(
                    diagnose.imagePath!,
                    width: w * 0.75,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholderImage(w),
                  )
                      : _placeholderImage(w),
                ),
              ),
              SizedBox(height: h * 0.03),

              // ── Diagnosis Result Card ─────────────────────────
              _sectionTitle('Diagnoses Result'),
              SizedBox(height: h * 0.012),
              _infoCard(w, h, [
                _InfoRow(label: 'Diagnosis',    value: diagnose.diseaseType),
                _InfoRow(label: 'Severity',     value: diagnose.severity ?? '-'),
                _InfoRow(label: 'Confidence',   value: diagnose.confidencePercent),
                _InfoRow(label: 'Status',       value: diagnose.status),
                _InfoRow(label: 'Date',         value: diagnose.createdAt ?? '-'),
                if (diagnose.notes != null && diagnose.notes!.isNotEmpty)
                  _InfoRow(label: 'Notes', value: diagnose.notes!),
              ]),

              SizedBox(height: h * 0.025),

              // ── Patient Information Card ──────────────────────
              _sectionTitle('Patient Information'),
              SizedBox(height: h * 0.012),
              _infoCard(w, h, [
                _InfoRow(label: 'Name',   value: patient.name),
                _InfoRow(label: 'Age',    value: patient.age.toString()),
                _InfoRow(label: 'Gender', value: patient.gender),
                _InfoRow(label: 'National ID', value: patient.nationalId),
                if (patient.phone != null && patient.phone!.isNotEmpty)
                  _InfoRow(label: 'Phone', value: patient.phone!),
              ]),

              SizedBox(height: h * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────
  Widget _placeholderImage(double w) {
    return Image.asset(
      'assets/images/Central-Retinal-Artery-Occlusion 1.png',
      width: w * 0.75,
      fit: BoxFit.cover,
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: const Color(0xff5E5757),
          fontWeight: FontWeight.bold,
          fontSize: 16),
    );
  }

  Widget _infoCard(double w, double h, List<_InfoRow> rows) {
    return Center(
      child: Container(
        width: w * 0.9,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rows
              .map((row) => Padding(
            padding: EdgeInsets.only(bottom: h * 0.016),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.label,
                    style: GoogleFonts.poppins(color: Colors.grey)),
                Text(row.value,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff5E5757),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ))
              .toList(),
        ),
      ),
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
}