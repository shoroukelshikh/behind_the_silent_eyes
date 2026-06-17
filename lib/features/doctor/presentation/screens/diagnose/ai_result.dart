import 'dart:io';
import 'package:behind_silent_eyes/core/network/api_endpoints.dart';
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
  final File? localImage;

  const AiResult({
    super.key,
    this.diagnose,
    this.patient,
    this.localImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is ReportGenerated) {
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
            'AI Diagnosis Result',
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
              // ── Eye Image ──────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: _buildImage(),
                ),
              ),

              const SizedBox(height: 20),

              // ── Diagnosis Result Card ───────────────────────────
              _SectionCard(
                title: 'Diagnosis result',
                icon: Icons.biotech_rounded,
                children: [
                  _InfoRow(label: 'Diagnosis',      value: diagnose?['disease']    ?? '-'),
                  _InfoRow(label: 'Severity level', value: diagnose?['severity']   ?? '-'),
                  _InfoRow(label: 'Confidence',     value: diagnose?['confidence'] ?? '-'),
                  _InfoRow(label: 'Date',           value: diagnose?['date']       ?? '-'),
                  _InfoRow(label: 'Status',         value: diagnose?['status']     ?? '-', isLast: true),
                ],
              ),

              const SizedBox(height: 16),

              // ── Patient Info Card ───────────────────────────────
              _SectionCard(
                title: 'Patient information',
                icon: Icons.person_outlined,
                children: [
                  _InfoRow(label: 'Name',   value: patient?['name']   ?? '-'),
                  _InfoRow(label: 'Age',    value: patient?['age']    ?? '-'),
                  _InfoRow(label: 'Gender', value: patient?['gender'] ?? '-', isLast: true),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    final imagePath = diagnose?['image_path']?.toString() ?? '';
    if (imagePath.isNotEmpty) {
      final base = ApiEndpoints.baseUrl.replaceAll('/api', '');
      final url  = '$base/storage/$imagePath';
      return Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : Container(
          color: AppColors.border,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorBuilder: (_, __, ___) => localImage != null
            ? Image.file(localImage!, fit: BoxFit.cover)
            : _fallback(),
      );
    }
    if (localImage != null) {
      return Image.file(localImage!, fit: BoxFit.cover);
    }
    return _fallback();
  }

  Widget _fallback() => Image.asset(
    'assets/images/conjunctiva.jpg',
    fit: BoxFit.cover,
  );
}

// ── Reusable section card ─────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
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
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, color: AppColors.border, indent: 16, endIndent: 16),
      ],
    );
  }
}