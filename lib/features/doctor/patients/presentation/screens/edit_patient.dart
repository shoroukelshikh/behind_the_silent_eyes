import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/drop_down.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/admin/doctors/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class EditPatient extends StatefulWidget {
  final Map<String, String> patient;
  const EditPatient({super.key, required this.patient});
  @override
  State<EditPatient> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  late final TextEditingController fullNameController;
  late final TextEditingController ageController;
  late final TextEditingController nationalIdController;
  late final TextEditingController dobController;
  late final TextEditingController medicalHistoryController;

  String? _selectedGender;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.patient["name"]);
    nationalIdController = TextEditingController(text: widget.patient["national_id"]);
    ageController = TextEditingController(text: widget.patient["age"] );
    dobController = TextEditingController(text: widget.patient["date_of_birth"]);
    medicalHistoryController = TextEditingController(text: widget.patient["medical_history"]);
    _selectedGender = widget.patient["gender"];
  }
  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    nationalIdController.dispose();
    dobController.dispose();
    medicalHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(Icons.arrow_back_ios_new, color: Color(0xff665F5F)),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.primary
        ),
        child: Form(
            key:_formKey ,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  CustomTextField(
                    label: "Fullname",
                    hintText: "Please enter the name",
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return "Name is required";
                      if (value.trim().length < 8) return "Name must be at least 8 characters";
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) return "Name must contain letters only";
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    label: "National ID",
                    hintText: "Please enter the ID",
                    controller: nationalIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "National ID is required";
                      final digits = value.replaceAll(' ', '');
                      if (digits.length < 14) return "Enter a valid 14-digit National ID";
                      if (!RegExp(r'^[0-9]+$').hasMatch(digits)) return "National ID must contain digits only";
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    label: "Age",
                    hintText: "Please enter the age",
                    controller: ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Age is required";
                      final age = int.tryParse(value);
                      if (age == null) return "Age must be a number";
                      if (age <= 0 || age > 120) return "Enter a valid age";
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    readOnly: true,
                    label: "Date of Birth",
                    hintText: "mm/dd/yyyy",
                    controller: dobController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Date of birth is required";
                      return null;
                    },
                    suffixIcon: const Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomDropdownField(
                    label: 'Gender',
                    hintText: 'Select gender',
                    items: const ['Male', 'Female'],
                    value: _selectedGender,
                    onChanged: (val) => setState(() => _selectedGender = val),
                    validator: (val) => val == null ? 'Please select a gender' : null,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    label: "Medical History",
                    hintText: "Enter patient medical history, existing conditions and allergies.",
                    controller: medicalHistoryController,
                    maxLines: 7,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return "Medical history is required";
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Cancel",
                          onPressed: () => Navigator.pop(context),
                          size: 16,
                          weight: FontWeight.w600,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          color: Color(0xff474161),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      Expanded(
                        child: CustomButton(
                          text: "Save",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.patient["name"] = fullNameController.text.trim();
                              widget.patient["national_id"] = nationalIdController.text.trim();
                              widget.patient["age"] = ageController.text.trim();
                              widget.patient["date_of_birth"] = dobController.text.trim();
                              widget.patient["medical_history"] = medicalHistoryController.text.trim();
                              widget.patient["gender"] = _selectedGender!;
                              Navigator.pop(context);
                            }
                          },
                          size: 16,
                          weight: FontWeight.w600,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          color: Color(0xff474161),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
        )),
      ),
    );
  }
}
