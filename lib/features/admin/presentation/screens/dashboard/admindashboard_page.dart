import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:behind_silent_eyes/features/admin/presentation/cubit/admin_state.dart';
import 'package:behind_silent_eyes/features/admin/presentation/screens/doctors/add_doc.dart';
import 'package:behind_silent_eyes/features/admin/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AdmindashboardPage extends StatefulWidget {
  const AdmindashboardPage({super.key});

  @override
  State<AdmindashboardPage> createState() => _AdmindashboardPageState();
}

class _AdmindashboardPageState extends State<AdmindashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().loadStats();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        int totalDoctors     = 0;
        int totalPatients    = 0;
        int totalPredictions = 0;
        bool isLoading       = false;

        if (state is AdminLoading) {
          isLoading = true;
        } else if (state is AdminStatsLoaded) {
          totalDoctors     = state.stats.totalDoctors;
          totalPatients    = state.stats.totalPatients;
          totalPredictions = state.stats.totalPredictions;
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App Bar ──────────────────────────────────────
              Container(
                height: 64,
                color: AppColors.navy,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/appbar.png', height: 28),
                    if (isLoading)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Quick Actions ───────────────────────────
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

                    InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddDoc()),
                        );
                        if (result == true && mounted) {
                          context.read<AdminCubit>().loadStats();
                        }
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 160,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.navy,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            const Icon(Icons.person_add_alt_1_rounded,
                                color: Colors.white, size: 22),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Add new doctor',
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
                    ),

                    const SizedBox(height: 28),
                    const Divider(color: AppColors.border, height: 1),
                    const SizedBox(height: 28),

                    // ── Statistics ──────────────────────────────
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

                    if (state is AdminFailure)
                      Container(
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.dangerBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.danger.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline_rounded,
                                color: AppColors.danger, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                state.message,
                                style: GoogleFonts.poppins(
                                  color: AppColors.danger,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.read<AdminCubit>().loadStats(),
                              child: Text(
                                'Retry',
                                style: GoogleFonts.poppins(
                                    color: AppColors.danger,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        StatCard(
                          text: 'Total Patients',
                          num: totalPatients.toString(),
                          icon: 'assets/images/total patients.png',
                        ),
                        const SizedBox(width: 12),
                        StatCard(
                          text: 'Total Predictions',
                          num: totalPredictions.toString(),
                          icon: 'assets/images/total predictions.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    StatCard(
                      text: 'Total Doctors',
                      num: totalDoctors.toString(),
                      icon: 'assets/images/total doctors.png',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}