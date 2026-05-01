import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/drop_down.dart';
import 'package:behind_silent_eyes/core/widgets/elevated_button.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../admin/presentation/widgets/text_field.dart';

class EditPatient extends StatefulWidget {
  final Map<String, String> patient;
  const EditPatient({super.key, required this.patient});

  @override
  State<EditPatient> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _ageController;
  late final TextEditingController _nationalIdController;
  late final TextEditingController _dobController;
  late final TextEditingController _medicalHistoryController;
  String? _selectedGender;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fullNameController      = TextEditingController(text: widget.patient['name']);
    _ageController           = TextEditingController(text: widget.patient['age']);
    _nationalIdController    = TextEditingController(text: widget.patient['national_id']);
    _dobController           = TextEditingController(text: widget.patient['date_of_birth']);
    _medicalHistoryController = TextEditingController(text: widget.patient['medical_history']);
    _selectedGender          = widget.patient['gender'];
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _nationalIdController.dispose();
    _dobController.dispose();
    _medicalHistoryController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is PatientUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Patient updated successfully')),
          );
          Navigator.pop(context);
        }
        if (state is DoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Color(0xff665F5F)),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.primary),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  CustomTextField(
                    label: 'Fullname',
                    hintText: 'Please enter the name',
                    controller: _fullNameController,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Name required';
                      if (v.trim().length < 3) return 'Min 3 characters';
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    label: 'National ID',
                    hintText: 'Please enter the ID',
                    controller: _nationalIdController,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'National ID required';
                      if (v.replaceAll(' ', '').length < 14)
                        return '14 digits required';
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    label: 'Age',
                    hintText: 'Please enter the age',
                    controller: _ageController,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Age required';
                      final age = int.tryParse(v);
                      if (age == null || age <= 0 || age > 120)
                        return 'Enter valid age';
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: CustomTextField(
                        label: 'Date of Birth',
                        hintText: 'YYYY-MM-DD',
                        controller: _dobController,
                        suffixIcon: const Icon(Icons.calendar_today),
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Date required' : null,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomDropdownField(
                    label: 'Gender',
                    hintText: 'Select gender',
                    items: const ['male', 'female'],
                    value: _selectedGender,
                    onChanged: (val) =>
                        setState(() => _selectedGender = val),
                    validator: (val) =>
                    val == null ? 'Please select a gender' : null,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    label: 'Medical History',
                    hintText: 'Enter existing conditions and allergies',
                    controller: _medicalHistoryController,
                    maxLines: 4,
                    validator: (_) => null,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  BlocBuilder<DoctorCubit, DoctorState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Cancel',
                              onPressed: () => Navigator.pop(context),
                              size: 16,
                              weight: FontWeight.w600,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.06,
                              color: const Color(0xff474161),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                          Expanded(
                            child: CustomButton(
                              text: state is DoctorLoading ? 'Saving...' : 'Save',
                              onPressed: state is DoctorLoading
                                  ? () {}
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  final id = int.parse(widget.patient['id']!);
                                  context.read<DoctorCubit>().updatePatient(
                                    id,
                                    {
                                      'name':            _fullNameController.text.trim(),
                                      'age':             int.parse(_ageController.text),
                                      'gender':          _selectedGender!,
                                      'date_of_birth':   _dobController.text,
                                      'national_id':     _nationalIdController.text.trim(),
                                      'medical_history': _medicalHistoryController.text.trim(),
                                    },
                                  );
                                }
                              },
                              size: 16,
                              weight: FontWeight.w600,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.06,
                              color: const Color(0xff474161),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}