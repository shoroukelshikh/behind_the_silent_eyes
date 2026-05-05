import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/domain/entities/doctor_entity.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/doctors/edit_doc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/gradient_card.dart';

class DocDetails extends StatelessWidget {
  final DoctorEntity doctor;

  const DocDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color(0xff665F5F), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Details',
          style: GoogleFonts.poppins(
            color: const Color(0xff665F5F),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xff665F5F)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditDoc(doctor: doctor),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primary),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // ── Avatar ───────────────────────────────────────
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFF474161),
                  child: Icon(Icons.person, size: 52, color: Colors.white),
                ),
                const SizedBox(height: 12),

                Text(
                  doctor.name,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff474161),
                  ),
                ),
                Text(
                  doctor.role.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.blueGrey,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 24),

                // ── Info Card ────────────────────────────────────
                GradientCard(
                  height: 300,
                  width: double.infinity,
                  children: [
                    _DetailRow(
                        icon: Icons.badge_outlined,
                        label: 'Doctor Code',
                        value: doctor.doctorCode ?? '—'),
                    const Divider(color: Colors.white24),
                    _DetailRow(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: doctor.email),
                    const Divider(color: Colors.white24),
                    _DetailRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: doctor.phone ?? '—'),
                    const Divider(color: Colors.white24),
                    _DetailRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Joined',
                        value: doctor.createdAt != null
                            ? doctor.createdAt!.substring(0, 10)
                            : '—'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}