import 'dart:io';
import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:behind_silent_eyes/features/doctor/data/models/prediction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'ai_result.dart';

class Diagnose extends StatefulWidget {
  final Map<String, String> patient;
  const Diagnose({super.key, required this.patient});

  @override
  State<Diagnose> createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  String? selectedDisease;
  File? image;
  final picker = ImagePicker();

  final List<String> diseases = [
    'Diabetic Retinopathy',
    'Anemia Detection',
    'Hypertensive Retinopathy',
  ];

  // Flutter disease name → API slug
  String _toSlug(String disease) {
    switch (disease) {
      case 'Diabetic Retinopathy':
        return 'diabetes';
      case 'Anemia Detection':
        return 'anemia';
      case 'Hypertensive Retinopathy':
        return 'hypertensive_retinopathy';
      default:
        return disease.toLowerCase().replaceAll(' ', '_');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width  = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocListener<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is PredictionSuccess) {
          final prediction = state.prediction as PredictionModel;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AiResult(
                diagnose: prediction.toDisplayMap(),
                patient:  widget.patient,
              ),
            ),
          );
        }
        if (state is DoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
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
                        Text('Patient: ',
                            style: GoogleFonts.poppins(
                                color: const Color(0xff665F5F), fontSize: 16)),
                        Text(widget.patient['name'] ?? '',
                            style: GoogleFonts.poppins(
                                color: const Color(0xff665F5F),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    Text('Select Disease type',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff5E5757),
                            fontSize: 18)),
                    SizedBox(height: height * 0.02),
                    ...diseases.map((disease) => RadioListTile<String>(
                      title: Text(disease),
                      value: disease,
                      groupValue: selectedDisease,
                      onChanged: (value) =>
                          setState(() => selectedDisease = value),
                    )),
                    SizedBox(height: height * 0.02),
                    Text('Upload image',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff5E5757),
                            fontSize: 18)),
                    SizedBox(height: height * 0.01),
                    InkWell(
                      onTap: () async {
                        final picked = await picker.pickImage(
                            source: ImageSource.gallery);
                        if (picked != null) {
                          setState(() => image = File(picked.path));
                        }
                      },
                      child: Container(
                        width: width * 0.8,
                        height: height * 0.20,
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: image == null
                              ? Text('Click to upload photo',
                              style: const TextStyle(
                                  color: Color(0xff5E5757)))
                              : Image.file(image!,
                              height: height * 0.15, width: width * 0.8),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    BlocBuilder<DoctorCubit, DoctorState>(
                      builder: (context, state) {
                        return state is DoctorLoading
                            ? Column(
                          children: [
                            const CircularProgressIndicator(),
                            SizedBox(height: height * 0.01),
                            Text('Analyzing image...',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff5E5757))),
                          ],
                        )
                            : CustomButton(
                          text: 'Analyze Image',
                          onPressed: () {
                            if (selectedDisease == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please select a disease type')),
                              );
                              return;
                            }
                            if (image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                    Text('Please upload an image')),
                              );
                              return;
                            }
                            final patientId =
                            int.tryParse(widget.patient['id'] ?? '');
                            if (patientId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                    Text('Invalid patient ID')),
                              );
                              return;
                            }
                            context.read<DoctorCubit>().predict(
                              patientId:   patientId,
                              diseaseType: _toSlug(selectedDisease!),
                              image:       image!,
                            );
                          },
                          size: 15,
                          weight: FontWeight.bold,
                          width: width * 0.8,
                          height: height * 0.05,
                          color: const Color(0xff474161),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.04),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}