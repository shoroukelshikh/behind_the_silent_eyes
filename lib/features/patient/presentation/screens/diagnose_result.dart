import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagnoseResult extends StatefulWidget {
  final Map <String, dynamic>? diagnose;
  final Map<String, String>? patient;
  const DiagnoseResult({super.key, this.diagnose,this.patient});

  @override
  State<DiagnoseResult> createState() => _DiagnoseResultState();
}

class _DiagnoseResultState extends State<DiagnoseResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'AI Diagnosis Result',
          style: GoogleFonts.poppins(
            color: Color(0xff5E5757),
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * .01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Center(
                  child: Image.asset(
                    'assets/images/Central-Retinal-Artery-Occlusion 1.png',
                  ),
                ),
                Text(
                  "Diagnoses result",
                  style: GoogleFonts.poppins(
                    color: Color(0xff5E5757),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * .01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diagnosis:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            widget.diagnose!["disease"],
                            style: GoogleFonts.poppins(
                              color: Color(0xff5E5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Severity level:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            widget.diagnose!["severity"],
                            style: GoogleFonts.poppins(
                              color: Color(0xff5E5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Confidence:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            widget.diagnose!["confidence"],
                            style: GoogleFonts.poppins(
                              color: Color(0xff5E5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Date:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            widget.diagnose!["date"],
                            style: GoogleFonts.poppins(
                              color: Color(0xff5E5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                Text(
                  "Patient information",
                  style: GoogleFonts.poppins(
                    color: Color(0xff5E5757),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * .01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            (widget.patient?["name"]?? ""),
                            style: GoogleFonts.poppins(
                              color: Color(0xff5E5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Age:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            '55.',
                            style: GoogleFonts.poppins(
                              color: Color(0xff5E5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'Gender:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            (widget.patient?["gender"]?? ""),
                            style: GoogleFonts.poppins(
                              color: Color(0xff5E5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Center(
                            child: InkWell(
                              child: Text(
                                'Download report',
                                style: GoogleFonts.poppins(
                                  color: Color(0xff162BE8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 3,
                                  decorationColor: Color(0xff162BE8),
                                ),
                              ),
                              onTap: () {
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ],
                      ),
                    ),
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
