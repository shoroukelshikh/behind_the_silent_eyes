import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/screens/patients/Diagnoses_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../admin/presentation/widgets/gradient_card.dart';

class DocPatientDetails extends StatelessWidget {
  final Map<String, String> patient;
  const DocPatientDetails({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Back to patients',
          style: GoogleFonts.poppins(
            color: Color(0xff665F5F),
            fontSize: 15,
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
                GradientCard(
                  width: width * .8,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.02,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.white),
                      SizedBox(width: width * 0.02),                          Text(
                            patient["name"] ?? "",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: width * .003, color: Color(0x66ffffff)),
                    // national id
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Image.asset('assets/images/code.png'),
                          SizedBox(width: width * .04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'national_id:',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                patient["national_id"] ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    // date of birth
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Image.asset('assets/images/date.png'),
                          SizedBox(width: width * .04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'date of birth',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                patient["date_of_birth"] ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    // Gender
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Icon(
                            Icons.transgender,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(width: width * .04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'gender',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                patient["gender"] ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    //registered on
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Image.asset("assets/images/date.png"),
                          SizedBox(width: width * .04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Registered on',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                patient["registered_on"] ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    //medical history
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Image.asset("assets/images/medical history.png"),
                          SizedBox(width: width * .04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Medical history',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                patient["medical_history"] ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.022),
                GradientCard(
                  width: width * .8,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.02,
                      ),
                      child: Text(
                        "Diagnoses History",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Divider(thickness: width * .003, color: Color(0x66ffffff)),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Disease type',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                "Diabetes",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                "10/5/2025",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'severity',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                "moderate",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'confidence',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0x66ffffff),
                                ),
                              ),
                              Text(
                                "84%",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text(
                              'view all',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DiagnosesHistory(patient: patient,),));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
