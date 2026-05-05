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
        int totalDoctors = 0;
        int totalPatients = 0;
        int totalPredictions = 0;
        bool isLoading = false;

        if (state is AdminLoading) {
          isLoading = true;
        } else if (state is AdminStatsLoaded) {
          totalDoctors = state.stats.totalDoctors;
          totalPatients = state.stats.totalPatients;
          totalPredictions = state.stats.totalPredictions;
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── App Bar ────────────────────────────────────────
              Container(
                height: 78,
                decoration: const BoxDecoration(
                  color: Color(0xFF474161),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset('assets/images/appbar.png'),
                    ),
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 21),

              // ── Quick Actions ──────────────────────────────────
              Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    'Quick Actions:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xff665F5F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 19),

              InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddDoc()),
                  );
                  // Reload stats if a doctor was added
                  if (result == true && mounted) {
                    context.read<AdminCubit>().loadStats();
                  }
                },
                child: Container(
                  width: 169,
                  height: 83,
                  decoration: BoxDecoration(
                    color: const Color(0x99474161),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff000000).withAlpha(50),
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/Add new doctor.png'),
                      Text(
                        'Add new Doctor',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(thickness: .7, color: Color(0xcc474161)),
              const SizedBox(height: 30),

              // ── Stats Section ──────────────────────────────────
              Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    'Statistics:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xff665F5F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (state is AdminFailure)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.read<AdminCubit>().loadStats(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatCard(
                    text: 'Total Patients',
                    num: isLoading ? '...' : totalPatients.toString(),
                    icon: 'assets/images/total patients.png',
                  ),
                  StatCard(
                    text: 'Total Predictions',
                    num: isLoading ? '...' : totalPredictions.toString(),
                    icon: 'assets/images/total predictions.png',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              StatCard(
                text: 'Total Doctors',
                num: isLoading ? '...' : totalDoctors.toString(),
                icon: 'assets/images/total doctors.png',
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}