import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/doctor/diagnose/presentation/screens/ai_result.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/colors.dart';

class DiagnosesHistory extends StatelessWidget {
  final Map<String, String>? patient;

  DiagnosesHistory({super.key, required this.patient});
  final List<Map<String, dynamic>> diagnoses = [
    {
      "disease": "anemia",
      "severity": "-",
      "confidence": "57%",
      "date": "2026-04-21",
    },
    {
      "disease": "hypertension",
      "severity": "High",
      "confidence": "80%",
      "date": "2026-04-20",
    },
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "back to patient details",
          style: GoogleFonts.poppins(fontSize: 18, color: Color(0xff665F5F)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: ListView.builder(
          itemCount: diagnoses.length,
          itemBuilder: (context, index) {
            final item = diagnoses[index];
            return Card(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: Row(
                  children: [
                    // LEFT SIDE (data)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["disease"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: height * 0.008),
                          Text(
                            "Severity: ${item["severity"]}",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(
                            "Confidence: ${item["confidence"]}",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(
                            "Date: ${item["date"]}",
                            style: GoogleFonts.poppins(),
                          ),
                        ],
                      ),
                    ),
                    // RIGHT SIDE (buttons)
                    Column(
                      children: [
                        CustomButton(
                          text: "view",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AiResult(
                                  diagnose: diagnoses[index],
                                  patient: patient,
                                ),
                              ),
                            );
                          },
                          size: 14,
                          weight: FontWeight.w400,
                          width: width * 0.30,
                          height: height * 0.04,
                        ),
                        SizedBox(height: height * 0.01),
                        CustomButton(
                          text: "Download",
                          onPressed: () {},
                          size: 14,
                          weight: FontWeight.w400,
                          width: width * 0.30,
                          height: height * 0.04,
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
    );
  }
}
