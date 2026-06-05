import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/domain/entities/doctor_entity.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/doctors/edit_doc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocDetails extends StatelessWidget {
  final DoctorEntity doctor;

  const DocDetails({super.key, required this.doctor});

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
          'Doctor details',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            tooltip: 'Edit',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EditDoc(doctor: doctor)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── Profile header ─────────────────────────────────────
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
                    doctor.name,
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
                      doctor.role.toUpperCase(),
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

            // ── Details card ───────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  // header
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
                          child: const Icon(Icons.info_outline_rounded,
                              color: AppColors.accent, size: 17),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Account information',
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
                  // rows
                  _DetailRow(
                    icon: Icons.badge_outlined,
                    label: 'Doctor code',
                    value: doctor.doctorCode ?? '—',
                  ),
                  const Divider(height: 1, color: AppColors.border,
                      indent: 16, endIndent: 16),
                  _DetailRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: doctor.email,
                  ),
                  const Divider(height: 1, color: AppColors.border,
                      indent: 16, endIndent: 16),
                  _DetailRow(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: doctor.phone ?? '—',
                  ),
                  const Divider(height: 1, color: AppColors.border,
                      indent: 16, endIndent: 16),
                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Joined',
                    value: doctor.createdAt != null
                        ? doctor.createdAt!.substring(0, 10)
                        : '—',
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Edit button ────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: Text(
                  'Edit doctor',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditDoc(doctor: doctor)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}