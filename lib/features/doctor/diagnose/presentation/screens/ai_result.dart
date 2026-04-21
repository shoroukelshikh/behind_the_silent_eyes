import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiResult extends StatelessWidget {
  const AiResult({super.key});

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
                            'Disease:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            'Diabetes.',
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
                            'Diagnosis:',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Text(
                            'Diabetes.',
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
                            'Moderate',
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
                            '80%',
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
                            '12/5/2026',
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
                            'mona.',
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
                            'Female',
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
