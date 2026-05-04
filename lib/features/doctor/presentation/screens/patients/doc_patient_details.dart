import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/Diagnoses_history.dart';
import 'package:behind_silent_eyes/features/doctor/data/models/prediction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../admin/presentation/widgets/gradient_card.dart';

class DocPatientDetails extends StatefulWidget {
  final Map<String, String> patient;
  const DocPatientDetails({super.key, required this.patient});

  @override
  State<DocPatientDetails> createState() => _DocPatientDetailsState();
}

class _DocPatientDetailsState extends State<DocPatientDetails> {
  @override
  void initState() {
    super.initState();
    // نجيب آخر diagnoses للمريض ده
    final patientId = int.tryParse(widget.patient['id'] ?? '');
    if (patientId != null) {
      context.read<DoctorCubit>().getHistory(patientId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width  = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Back to patients',
          style: GoogleFonts.poppins(
            color:      const Color(0xff665F5F),
            fontSize:   15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.1),

                // ── Patient Info Card ──────────────────────────
                GradientCard(
                  width: width * .8,
                  children: [
                    // Name
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical:   height * 0.02,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: Colors.white),
                          SizedBox(width: width * 0.02),
                          Text(
                            widget.patient['name'] ?? '',
                            style: GoogleFonts.poppins(
                              fontSize:   15,
                              fontWeight: FontWeight.bold,
                              color:      Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _divider(width),

                    // National ID
                    _infoRow(
                      width:  width,
                      height: height,
                      icon:   Image.asset('assets/images/code.png'),
                      label:  'National ID',
                      value:  widget.patient['national_id'] ?? '',
                    ),

                    // Date of Birth
                    _infoRow(
                      width:  width,
                      height: height,
                      icon:   Image.asset('assets/images/date.png'),
                      label:  'Date of birth',
                      value:  widget.patient['date_of_birth'] ?? '',
                    ),

                    // Gender
                    _infoRow(
                      width:  width,
                      height: height,
                      icon:   const Icon(Icons.transgender, color: Colors.white, size: 25),
                      label:  'Gender',
                      value:  widget.patient['gender'] ?? '',
                    ),

                    // Phone
                    _infoRow(
                      width:  width,
                      height: height,
                      icon:   const Icon(Icons.phone, color: Colors.white, size: 25),
                      label:  'Phone',
                      value:  widget.patient['phone']?.isEmpty ?? true
                          ? '—'
                          : widget.patient['phone']!,
                    ),

                    // Registered On
                    _infoRow(
                      width:  width,
                      height: height,
                      icon:   Image.asset('assets/images/date.png'),
                      label:  'Registered on',
                      value:  widget.patient['registered_on'] ?? '',
                    ),

                    // Medical History
                    _infoRow(
                      width:   width,
                      height:  height,
                      icon:    Image.asset('assets/images/medical history.png'),
                      label:   'Medical history',
                      value:   widget.patient['medical_history']?.isEmpty ?? true
                          ? '—'
                          : widget.patient['medical_history']!,
                      isLast: true,
                    ),
                  ],
                ),

                SizedBox(height: height * 0.022),

                // ── Diagnoses History Card ─────────────────────
                GradientCard(
                  width: width * .8,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical:   height * 0.02,
                      ),
                      child: Text(
                        'Diagnoses History',
                        style: GoogleFonts.poppins(
                          fontSize:   15,
                          fontWeight: FontWeight.bold,
                          color:      Colors.white,
                        ),
                      ),
                    ),
                    _divider(width),

                    BlocBuilder<DoctorCubit, DoctorState>(
                      builder: (context, state) {
                        // Loading
                        if (state is DoctorLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child:   Center(child: CircularProgressIndicator(color: Colors.white)),
                          );
                        }

                        // Error
                        if (state is DoctorFailure) {
                          return Padding(
                            padding: EdgeInsets.all(width * 0.05),
                            child: Text(
                              state.message,
                              style: GoogleFonts.poppins(color: Colors.redAccent),
                            ),
                          );
                        }

                        // Loaded
                        if (state is HistoryLoaded) {
                          if (state.predictions.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.all(width * 0.05),
                              child: Text(
                                'No diagnoses yet',
                                style: GoogleFonts.poppins(color: Colors.white70),
                              ),
                            );
                          }

                          // نعرض آخر diagnosis بس (الأحدث)
                          final latest = state.predictions.first as PredictionModel;

                          return Column(
                            children: [
                              _diagRow(width, height, 'Disease type', latest.diseaseType),
                              _diagRow(width, height, 'Date',         latest.createdAt ?? '—'),
                              _diagRow(width, height, 'Severity',     latest.severity  ?? '—'),
                              _diagRow(width, height, 'Confidence',   latest.confidencePercent),
                              SizedBox(height: height * 0.02),

                              // "view all" link
                              Padding(
                                padding: EdgeInsets.only(
                                  left:   width * 0.05,
                                  bottom: height * 0.02,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DiagnosesHistory(
                                            patient: widget.patient,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'view all (${state.predictions.length})',
                                        style: GoogleFonts.poppins(
                                          fontSize:        16,
                                          fontWeight:      FontWeight.bold,
                                          color:           Colors.white,
                                          decoration:      TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        // Initial — لو لسه ما حملناش
                        return Padding(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Text(
                            'Loading diagnoses...',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────
  Widget _divider(double width) =>
      Divider(thickness: width * .003, color: const Color(0x66ffffff));

  Widget _infoRow({
    required double  width,
    required double  height,
    required Widget  icon,
    required String  label,
    required String  value,
    bool             isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left:   width * 0.05,
        bottom: isLast ? height * 0.02 : 0,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Row(
              children: [
                icon,
                SizedBox(width: width * .04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: const Color(0x66ffffff))),
                    Text(value,
                        style: GoogleFonts.poppins(
                            fontSize:   16,
                            fontWeight: FontWeight.bold,
                            color:      Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          if (!isLast) _divider(width),
        ],
      ),
    );
  }

  Widget _diagRow(double width, double height, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, bottom: height * 0.015),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: const Color(0x66ffffff))),
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize:   16,
                      fontWeight: FontWeight.bold,
                      color:      Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}