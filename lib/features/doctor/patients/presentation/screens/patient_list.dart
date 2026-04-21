import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/core/widgets/search_field.dart';
import 'package:behind_silent_eyes/features/doctor/diagnose/presentation/screens/diagnose.dart';
import 'package:behind_silent_eyes/features/doctor/patients/presentation/screens/add_patient.dart';
import 'package:behind_silent_eyes/features/doctor/patients/presentation/screens/doc_patient_details.dart';
import 'package:behind_silent_eyes/features/doctor/patients/presentation/screens/edit_patient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  void initState() {
    filteredPatients = patients;
    super.initState();
  }

  List<Map<String, String>> patients = [
    {
      "name": "Ahmed Ali",
      "national_id": "2980 3151 2345 67",
      "date_of_birth": "15/03/1998",
      "gender": "Male",
      "medical_history": "Diabetes, Hypertension",
      "registered_on":"2/9/2025"
    },
    {
      "name": "Mohamed Hassan",
      "national_id": "2950 7221 2345 67",
      "date_of_birth": "22/07/1995",
      "gender": "Male",
      "medical_history": "Anemia",
      "registered_on":"2/9/2025"
    },
    {
      "name": "Sara Khaled",
      "national_id": "3000 1011 2345 67",
      "date_of_birth": "01/01/2000",
      "gender": "Female",
      "medical_history": "hypertension",
      "registered_on":"2/9/2025"
    },
  ];
  void searchPatient(String query) {
    setState(() {
      filteredPatients = patients.where((patient) {
        final name = patient["name"]!.toLowerCase();
        final national_id = patient["national_id"]!.toLowerCase();
        final search = query.toLowerCase();

        return name.contains(search) || national_id.contains(search);
      }).toList();
    });
  }

  List<Map<String, String>> filteredPatients = [];
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primary
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(child: Icon(Icons.arrow_back_ios_outlined),
                      onTap:() {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },),
                    Expanded(
                      child: SearchField(
                        onSearch: searchPatient,
                        hint: "Search patient by name or code",
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff474161),
                        minimumSize: Size(129, 32),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPatient()),
                        );
                      },
                      child: Text(
                        "Add patient",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Color(0xffffffff),
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: SizedBox(
                          width: 335,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row 1: Icon + Name + Edit
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Color(0xff68848C),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          filteredPatients[index]["name"]!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blueGrey,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPatient()
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),

                                // Row 2: patient id
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "National ID: ",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      filteredPatients[index]["national_id"]!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row 3: date of birth
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("date of birth: ", style: TextStyle(fontSize: 14)),
                                    Text(
                                      filteredPatients[index]["date_of_birth"]!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row 4: gender
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Gender:", style: TextStyle(fontSize: 14)),
                                    Text(
                                      filteredPatients[index]["gender"]!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row 4: medical history
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Medical history:", style: TextStyle(fontSize: 14)),
                                    Text(
                                      filteredPatients[index]["medical_history"]!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                // Last Row: View Button + diagnose button + delete
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                     CustomButton(text: "view", onPressed: () {
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>DocPatientDetails(patient: filteredPatients[index]),)
                                        );
                                      }, size: 14, weight: FontWeight.w400, width: 123, height: 26,color: Color(0xff474161),),


                                        CustomButton(text: "Diagnose", onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) =>Diagnose(patient: filteredPatients[index]),)
                                          );
                                        }, size: 14, weight: FontWeight.w400, width: 123, height: 26,color: Color(0xff0B2F60),),


                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        final patient = filteredPatients[index];
                                        setState(() {
                                          patients.remove(patient);
                                          filteredPatients.remove(patient);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
