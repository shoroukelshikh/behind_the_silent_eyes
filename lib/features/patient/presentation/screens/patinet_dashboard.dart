import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/auth/domain/entities/patient_entity.dart';
import 'package:behind_silent_eyes/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:behind_silent_eyes/features/patient/presentation/cubit/patient_cubit.dart';
import 'package:behind_silent_eyes/features/patient/presentation/cubit/patient_state.dart';
import 'package:behind_silent_eyes/features/patient/presentation/screens/patient_diagnoses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          final PatientEntity patient = state.patient ?? widget.patient;

          return CustomScrollView(
            slivers: [
              // ── App Bar ──────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 160,
                pinned: true,
                backgroundColor: AppColors.navy,
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout_rounded,
                        color: Colors.white, size: 22),
                    tooltip: 'Logout',
                    onPressed: () async {
                      await context.read<AuthCubit>().patientLogout();
                      if (context.mounted) {
                        Navigator.of(context).popUntil((r) => r.isFirst);
                      }
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    color: AppColors.navy,
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(Icons.person_rounded,
                                    color: Colors.white, size: 26),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.65),
                                  ),
                                ),
                                Text(
                                  patient.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Profile Card ──────────────────────────────
                    _SectionCard(
                      title: 'Profile information',
                      icon: Icons.person_outline_rounded,
                      child: state.isLoadingProfile
                          ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                            child: CircularProgressIndicator(
                                color: AppColors.accent)),
                      )
                          : state.profileError != null
                          ? _ErrorRetry(
                        message: state.profileError!,
                        onRetry: () =>
                            context.read<PatientCubit>().getProfile(),
                      )
                          : Column(
                        children: [
                          _InfoTile(
                              icon: Icons.badge_outlined,
                              label: 'National ID',
                              value: patient.nationalId),
                          _InfoTile(
                              icon: Icons.cake_outlined,
                              label: 'Date of Birth',
                              value: patient.dateOfBirth ?? '-'),
                          _InfoTile(
                              icon: Icons.transgender_rounded,
                              label: 'Gender',
                              value: patient.gender),
                          _InfoTile(
                              icon: Icons.phone_outlined,
                              label: 'Phone',
                              value: patient.phone ?? '-'),
                          _InfoTile(
                              icon: Icons.calendar_today_outlined,
                              label: 'Registered On',
                              value: patient.registeredOn ?? '-'),
                          if (patient.medicalHistory != null &&
                              patient.medicalHistory!.isNotEmpty)
                            _InfoTile(
                                icon:
                                Icons.medical_information_outlined,
                                label: 'Medical History',
                                value: patient.medicalHistory!),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Diagnoses Preview Card ────────────────────
                    _SectionCard(
                      title: 'Diagnoses history',
                      icon: Icons.history_rounded,
                      trailing: state.diagnoses != null &&
                          state.diagnoses!.isNotEmpty
                          ? GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PatientDiagnoses(patient: patient),
                          ),
                        ),
                        child: Text(
                          'View all',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                          : null,
                      child: state.isLoadingDiagnoses
                          ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                            child: CircularProgressIndicator(
                                color: AppColors.accent)),
                      )
                          : state.diagnosesError != null
                          ? _ErrorRetry(
                        message: state.diagnosesError!,
                        onRetry: () => context
                            .read<PatientCubit>()
                            .getDiagnoses(),
                      )
                          : (state.diagnoses == null ||
                          state.diagnoses!.isEmpty)
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24),
                        child: Center(
                          child: Text(
                            'No diagnoses yet.',
                            style: GoogleFonts.poppins(
                                color: AppColors.textSecondary,
                                fontSize: 14),
                          ),
                        ),
                      )
                          : Column(
                        children: [
                          _PreviewTile(
                            label: 'Disease type',
                            value: state
                                .diagnoses!.first.diseaseType,
                          ),
                          _PreviewTile(
                            label: 'Date',
                            value: state.diagnoses!.first
                                .createdAt ??
                                '-',
                          ),
                          _PreviewTile(
                            label: 'Severity',
                            value: state.diagnoses!.first
                                .severity ??
                                '-',
                          ),
                          _PreviewTile(
                            label: 'Confidence',
                            value: state
                                .diagnoses!.first.confidencePercent,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Section Card ─────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
  });

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
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ── Info Tile ─────────────────────────────────────────────────────
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontWeight: FontWeight.w400,
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

// ── Preview Tile ──────────────────────────────────────────────────
class _PreviewTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _PreviewTile(
      {required this.label, required this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
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
        if (!isLast) const Divider(height: 1, color: AppColors.border),
      ],
    );
  }
}

// ── Error + Retry ─────────────────────────────────────────────────
class _ErrorRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorRetry({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(message,
              style: GoogleFonts.poppins(
                  color: AppColors.danger, fontSize: 13),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetry,
            child: Text('Retry',
                style: GoogleFonts.poppins(
                    color: AppColors.accent, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
