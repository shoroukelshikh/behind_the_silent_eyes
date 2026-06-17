import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/add_patient.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../admin/presentation/widgets/stat_card.dart';

class DocDashboardPage extends StatelessWidget {
  const DocDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── App Bar ────────────────────────────────────────────
        Container(
          height: 64,
          color: AppColors.navy,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Image.asset('assets/images/appbar.png', height: 28),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Quick Actions ─────────────────────────────
                Text(
                  'Quick actions',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    _ActionTile(
                      label: 'Add new patient',
                      icon: Icons.person_add_alt_1_rounded,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddPatient()),
                      ),
                    ),
                    const SizedBox(width: 50),
                    _ActionTile(
                      label: 'Start diagnose',
                      icon: Icons.biotech_rounded,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PatientList()),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),
                const Divider(color: AppColors.border, height: 1),
                const SizedBox(height: 28),

                // ── Statistics ────────────────────────────────
                Text(
                  'Statistics',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    StatCard(
                      text: 'Total patients',
                      num: '5',
                      icon: 'assets/images/total patients.png',
                    ),
                    const SizedBox(width: 30),
                    StatCard(
                      text: 'Total diagnoses',
                      num: '7',
                      icon: 'assets/images/total predictions.png',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    StatCard(
                      text: "Today's diagnoses",
                      num: '2',
                      icon: 'assets/images/todaysdiagnose.png',
                    ),
                    const SizedBox(width: 30),
                    StatCard(
                      text: 'Active cases',
                      num: '7',
                      icon: 'assets/images/Activecases.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Reusable action tile ──────────────────────────────────────────
class _ActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 150,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}