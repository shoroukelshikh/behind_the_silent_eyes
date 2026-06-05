import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/core/widgets/search_field.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/diagnose/diagnose.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/add_patient.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/doc_patient_details.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/edit_patient.dart';
import 'package:behind_silent_eyes/features/doctor/data/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  List<PatientModel> allPatients      = [];
  List<PatientModel> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getPatients();
  }

  void searchPatient(String query) {
    setState(() {
      filteredPatients = allPatients.where((p) {
        final name = p.name.toLowerCase();
        final id   = p.nationalId.toLowerCase();
        return name.contains(query.toLowerCase()) ||
            id.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is PatientsLoaded) {
          setState(() {
            allPatients      = state.patients.cast<PatientModel>();
            filteredPatients = allPatients;
          });
        }
        if (state is PatientDeleted) {
          context.read<DoctorCubit>().getPatients();
        }
        if (state is DoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                children: [
                  // ── Search + Add ────────────────────────────
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_rounded,
                            color: AppColors.textPrimary, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SearchField(
                          onSearch: searchPatient,
                          hint: 'Search by name or ID',
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddPatient()),
                            );
                            if (context.mounted) {
                              context.read<DoctorCubit>().getPatients();
                            }
                          },
                          child: Text(
                            'Add',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── List ────────────────────────────────────
                  if (state is DoctorLoading)
                    const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                  else if (filteredPatients.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person_search_rounded,
                                size: 52, color: AppColors.textHint),
                            const SizedBox(height: 12),
                            Text('No patients found',
                                style: GoogleFonts.poppins(
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: RefreshIndicator(
                        color: AppColors.navy,
                        onRefresh: () => context.read<DoctorCubit>().getPatients(),
                        child: ListView.separated(
                          itemCount: filteredPatients.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final patient    = filteredPatients[index];
                            final patientMap = patient.toStringMap();
                            return _PatientCard(
                              patient:    patient,
                              patientMap: patientMap,
                              w:          w,
                              h:          h,
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 12, color: AppColors.textSecondary)),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

// ── Patient card ─────────────────────────────────────────────────
class _PatientCard extends StatelessWidget {
  final PatientModel patient;
  final Map<String, String> patientMap;
  final double w;
  final double h;

  const _PatientCard({
    required this.patient,
    required this.patientMap,
    required this.w,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ─────────────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.accentLight,
                child: Text(
                  patient.name.isNotEmpty
                      ? patient.name[0].toUpperCase()
                      : '?',
                  style: GoogleFonts.poppins(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  patient.name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    color: AppColors.textSecondary, size: 18),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditPatient(patient: patientMap),
                  ),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 10),

          // ── Info rows ──────────────────────────────────────
          _row('National ID', patient.nationalId),
          const SizedBox(height: 4),
          _row('Date of birth', patient.dateOfBirth),
          const SizedBox(height: 4),
          _row('Gender', patient.gender),
          const SizedBox(height: 4),
          _row('Medical history', patient.medicalHistory ?? '—'),

          const SizedBox(height: 12),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 10),

          // ── Actions ────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'View',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DocPatientDetails(patient: patientMap),
                    ),
                  ),
                  size: 13,
                  weight: FontWeight.w500,
                  width: double.infinity,
                  height: 38,
                  color: AppColors.navyLight,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(
                  text: 'Diagnose',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Diagnose(patient: patientMap),
                    ),
                  ),
                  size: 13,
                  weight: FontWeight.w500,
                  width: double.infinity,
                  height: 38,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.danger, size: 22),
                onPressed: () =>
                    context.read<DoctorCubit>().deletePatient(patient.id),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 12, color: AppColors.textSecondary)),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}