import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/add_patient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/patient_list.dart';
import '../../../../admin/presentation/widgets/stat_card.dart';

class DocDashboardPage extends StatelessWidget {
  const DocDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 78,
          decoration: BoxDecoration(
            color: Color(0xFF474161),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/images/appbar.png'),
              ),
            ],
          ),
        ),
        SizedBox(height: 21),
        Row(
          children: [
            SizedBox(width: 9),
            Text(
              "Quick Actions:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Color(0xff665F5F),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 19),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  AddPatient(),
                  ),
                );
              },
              child: Container(
                width: 169,
                height: 83,
                decoration: BoxDecoration(
                  color: Color(0x99474161),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff000000).withAlpha(50),
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                        blurRadius: 6
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/Add new doctor.png'),
                    Text(
                      'Add new Patient',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  PatientList(),
                  ),
                );
              },
              child: Container(
                width: 169,
                height: 83,
                decoration: BoxDecoration(
                  color: Color(0x99474161),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff000000).withAlpha(50),
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                        blurRadius: 6
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/Diagnose.png',color: Colors.white,),
                    Text(
                      'Start Diagnose',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Divider(thickness: .7, color: Color(0xcc474161)),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatCard(text: "Total patients", num: "5", icon:"assets/images/total patients.png" ),
            StatCard(text: "Total Diagnose", num: "7", icon: "assets/images/total predictions.png")
          ],
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatCard(text: "Today's Diagnoses", num: "2", icon:"assets/images/todaysdiagnose.png" ),
            StatCard(text: "Active cases", num: "7", icon:"assets/images/Activecases.png")
          ],
        ),
      ],
    );
  }
}
