import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/doctor/data/models/prediction_model.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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

  @override
  Widget build(BuildContext context) {
    double width  = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Back to patient details',
            style: GoogleFonts.poppins(
                fontSize: 18, color: const Color(0xff665F5F))),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state is DoctorLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DoctorFailure) {
              return Center(
                  child: Text(state.message,
                      style: GoogleFonts.poppins(color: Colors.red)));
            }
            if (state is HistoryLoaded) {
              if (state.predictions.isEmpty) {
                return Center(
                    child: Text('No diagnoses found',
                        style: GoogleFonts.poppins()));
              }
              return RefreshIndicator(
                onRefresh: () {
                  final id = int.tryParse(widget.patient?['id'] ?? '');
                  if (id != null) context.read<DoctorCubit>().getHistory(id);
                  return Future.value();
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(top: height * 0.1),
                  itemCount: state.predictions.length,
                  itemBuilder: (context, index) {
                    final item =
                    state.predictions[index] as PredictionModel;
                    // final displayMap = item.toDisplayMap();
                    return Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.01),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.03),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.diseaseType,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: height * 0.008),
                                  Text(
                                      'Severity: ${item.severity ?? '-'}',
                                      style: GoogleFonts.poppins()),
                                  Text(
                                      'Confidence: ${item.confidencePercent}',
                                      style: GoogleFonts.poppins()),
                                  Text('Date: ${item.createdAt ?? '-'}',
                                      style: GoogleFonts.poppins()),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                CustomButton(
                                  text: 'View',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AiResult(
                                          diagnose: {
                                            'id': item.id.toString(),
                                            'disease': item.diseaseType ?? '-',
                                            'severity': item.severity ?? '-',
                                            'confidence': item.confidence?.toString() ?? '-',
                                            'date': item.createdAt ?? '-',
                                            'status': item.status ?? '-',
                                            'image_path': item.imagePath ?? '', // 👈 أهم سطر
                                          },
                                          patient: {
                                            'id': widget.patient?['id'] ?? '',
                                            'name': widget.patient?['name'] ?? '-',
                                            'age': widget.patient?['age'] ?? '-',
                                            'gender': widget.patient?['gender'] ?? '-',
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  size: 14,
                                  weight: FontWeight.w400,
                                  width: width * 0.28,
                                  height: height * 0.04,
                                ),
                                SizedBox(height: height * 0.01),
                                // CustomButton(
                                //   text: 'Download',
                                //   onPressed: () {
                                //     context
                                //         .read<DoctorCubit>()
                                //         .generateReport(item.id);
                                //   },
                                //   size: 14,
                                //   weight: FontWeight.w400,
                                //   width: width * 0.28,
                                //   height: height * 0.04,
                                // ),
                              ],
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
      ),
    );
  }
}