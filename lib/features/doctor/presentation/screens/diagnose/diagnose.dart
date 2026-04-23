import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'ai_result.dart';

class Diagnose extends StatefulWidget {
  final Map <String, dynamic>? diagnose;
  final Map<String, String> patient;
  const Diagnose({super.key, required this.patient , this.diagnose});

  @override
  State<Diagnose> createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  String? selectedDisease;

  final List<String> diseases = [
    "Diabetic Retinopathy",
    "Anemia Detection",
    "Hypertensive Retinopathy",
  ];
  File? image;
  final picker = ImagePicker();
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "patient:",
                        style: GoogleFonts.poppins(
                          color: Color(0xff665F5F),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.patient["name"] ?? "",
                        style: GoogleFonts.poppins(
                          color: Color(0xff665F5F),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    "Select Disease type ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5E5757),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  ...diseases.map((disease) {
                    return RadioListTile<String>(
                      title: Text(disease),
                      value: disease,
                      groupValue: selectedDisease,
                      onChanged: (value) {
                        setState(() {
                          selectedDisease = value;
                        });
                      },
                    );
                  }),
                  SizedBox(height: height * 0.03),
                  Text(
                    "Upload image ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5E5757),
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final picked = await picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (picked != null) {
                        setState(() {
                          image = File(picked.path);
                        });
                      }
                    },
                    child: Container(
                      width: width * .8,
                      height: height * 0.20,
                      padding: EdgeInsets.all(width * 0.04),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: image == null
                            ? Text(
                                "Click to upload photo",
                                style: TextStyle(color: Color(0xff5E5757)),
                              )
                            : Image.file(
                                image!,
                                height: height * 0.15,
                                width: width * .8,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.25),                  CustomButton(
                    text: "Analyze Image",
                    onPressed: ()
                      {
                        if (selectedDisease == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select a disease type")),
                          );
                          return;
                        }

                        if (image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please upload an image")),
                          );
                          return;
                        }


                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AiResult(
                              diagnose: {
                                "disease": selectedDisease!,
                                "severity": "Moderate",   // replace with real AI result later
                                "confidence": "92%",      // replace with real AI result later
                                "date": DateTime.now().toString().split(' ')[0],
                              },
                              patient: widget.patient,
                            ),
                          ),
                        );
                    },
                    size: 15,
                    weight: FontWeight.bold,
                    width: width * 0.8,
                    height: height * 0.05,
                    color: Color(0xff474161),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
