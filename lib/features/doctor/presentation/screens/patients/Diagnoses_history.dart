import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/doctor/data/models/prediction_model.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../diagnose/ai_result.dart';

class DiagnosesHistory extends StatefulWidget {
  final Map<String, String>? patient;
  const DiagnosesHistory({super.key, required this.patient});

  @override
  State<DiagnosesHistory> createState() => _DiagnosesHistoryState();
}

class _DiagnosesHistoryState extends State<DiagnosesHistory> {
  @override
  void initState() {
    super.initState();
    final patientId = int.tryParse(widget.patient?['id'] ?? '');
    if (patientId != null) {
      context.read<DoctorCubit>().getHistory(patientId);
    }
  }

  Color _severityColor(String? severity) {
    switch (severity?.toLowerCase()) {
      case 'severe':
        return AppColors.danger;
      case 'moderate':
        return AppColors.warning;
      case 'mild':
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _severityBg(String? severity) {
    switch (severity?.toLowerCase()) {
      case 'severe':
        return AppColors.dangerBg;
      case 'moderate':
        return AppColors.warningBg;
      case 'mild':
        return AppColors.successBg;
      default:
        return AppColors.background;
    }
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
          'Diagnoses History',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DoctorLoading) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.accent));
          }
          if (state is DoctorFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      color: AppColors.danger, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message,
                      style: GoogleFonts.poppins(
                          color: AppColors.textSecondary, fontSize: 14)),
                ],
              ),
            );
          }
          if (state is HistoryLoaded) {
            if (state.predictions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.accentLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.history_rounded,
                          color: AppColors.accent, size: 40),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No diagnoses yet',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Past diagnoses will appear here',
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: AppColors.accent,
              onRefresh: () {
                final id = int.tryParse(widget.patient?['id'] ?? '');
                if (id != null) context.read<DoctorCubit>().getHistory(id);
                return Future.value();
              },
              child: ListView.separated(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: state.predictions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = state.predictions[index] as PredictionModel;
                  final sev = item.severity;

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Icon badge
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _severityBg(sev),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.biotech_rounded,
                              color: _severityColor(sev),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.diseaseType,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    _chip(sev ?? '—', _severityColor(sev),
                                        _severityBg(sev)),
                                    const SizedBox(width: 8),
                                    Text(
                                      item.confidencePercent,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_rounded,
                                        size: 12,
                                        color: AppColors.textSecondary),
                                    const SizedBox(width: 4),
                                    Text(
                                      item.createdAt ?? '—',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // View button
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AiResult(
                                  diagnose: {
                                    'id': item.id.toString(),
                                    'disease': item.diseaseType ?? '—',
                                    'severity': item.severity ?? '—',
                                    'confidence':
                                    item.confidence?.toString() ?? '—',
                                    'date': item.createdAt ?? '—',
                                    'status': item.status ?? '—',
                                    'image_path': item.imagePath ?? '',
                                  },
                                  patient: {
                                    'id': widget.patient?['id'] ?? '',
                                    'name': widget.patient?['name'] ?? '—',
                                    'age': widget.patient?['age'] ?? '—',
                                    'gender': widget.patient?['gender'] ?? '—',
                                  },
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.accentLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'View',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _chip(String text, Color fg, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}