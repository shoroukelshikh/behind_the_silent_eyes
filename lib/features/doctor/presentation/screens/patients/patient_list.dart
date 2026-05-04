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
  List<PatientModel> allPatients    = [];
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
          body: Container(
            decoration: BoxDecoration(gradient: AppColors.primary),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(w * 0.02),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (Navigator.canPop(context)) Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios_outlined),
                        ),
                        Expanded(
                          child: SearchField(
                            onSearch: searchPatient,
                            hint: 'Search patient by name or ID',
                          ),
                        ),
                        SizedBox(width: w * 0.03),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff474161),
                            minimumSize: Size(w * 0.3, h * 0.04),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AddPatient()),
                            );
                            if (context.mounted) {
                              context.read<DoctorCubit>().getPatients();
                            }
                          },
                          child: Text(
                            'Add patient',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.02),
                    if (state is DoctorLoading)
                      const Expanded(
                          child: Center(child: CircularProgressIndicator()))
                    else if (filteredPatients.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text('No patients found',
                              style: GoogleFonts.poppins()),
                        ),
                      )
                    else
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () =>
                              context.read<DoctorCubit>().getPatients(),
                          child: ListView.builder(
                            itemCount: filteredPatients.length,
                            itemBuilder: (context, index) {
                              final patient = filteredPatients[index];
                              final patientMap = patient.toStringMap();
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                margin: EdgeInsets.symmetric(
                                    vertical: h * 0.01,
                                    horizontal: w * 0.03),
                                child: Padding(
                                  padding: EdgeInsets.all(w * 0.03),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor:
                                                Color(0xff68848C),
                                                child: Icon(Icons.person,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: w * 0.02),
                                              Text(patient.name,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blueGrey),
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => EditPatient(
                                                      patient: patientMap),
                                                ),
                                              );
                                              if (context.mounted) {
                                                context
                                                    .read<DoctorCubit>()
                                                    .getPatients();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.01),
                                      _infoRow('National ID', patient.nationalId),
                                      _infoRow('Date of birth', patient.dateOfBirth),
                                      _infoRow('Gender', patient.gender),
                                      _infoRow('Medical history',
                                          patient.medicalHistory ?? '-'),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomButton(
                                            text: 'View',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      DocPatientDetails(
                                                          patient: patientMap),
                                                ),
                                              );
                                            },
                                            size: w * 0.035,
                                            weight: FontWeight.w400,
                                            width: w * 0.3,
                                            height: h * 0.04,
                                            color: const Color(0xff474161),
                                          ),
                                          CustomButton(
                                            text: 'Diagnose',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => Diagnose(
                                                      patient: patientMap),
                                                ),
                                              );
                                            },
                                            size: w * 0.035,
                                            weight: FontWeight.w400,
                                            width: w * 0.3,
                                            height: h * 0.04,
                                            color: const Color(0xff0B2F60),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              context
                                                  .read<DoctorCubit>()
                                                  .deletePatient(patient.id);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
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
        Text('$label: ', style: const TextStyle(fontSize: 14)),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}