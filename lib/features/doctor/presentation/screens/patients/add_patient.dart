import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/drop_down.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../admin/presentation/widgets/text_field.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final _fullNameController       = TextEditingController();
  final _ageController            = TextEditingController();
  final _nationalIdController     = TextEditingController();
  final _dobController            = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _formKey                  = GlobalKey<FormState>();
  String? _selectedGender;

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
        if (state is PatientAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Patient added successfully')),
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
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.navy,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Add New Patient',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ── Form card ────────────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Full name',
                        hintText: 'Please enter the name',
                        controller: _fullNameController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Name required';
                          if (v.trim().length < 3) return 'Min 3 characters';
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(v))
                            return 'Letters only';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'National ID',
                        hintText: 'Please enter the ID',
                        controller: _nationalIdController,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'National ID required';
                          if (v.length < 14) return '14 digits required';
                          if (!RegExp(r'^[0-9]+$').hasMatch(v)) return 'Digits only';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _pickDate,
                        child: AbsorbPointer(
                          child: CustomTextField(
                            label: 'Date of Birth',
                            hintText: 'YYYY-MM-DD',
                            controller: _dobController,
                            suffixIcon: const Icon(Icons.calendar_today_outlined,
                                color: AppColors.textSecondary, size: 20),
                            validator: (v) =>
                            v == null || v.isEmpty ? 'Date required' : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomDropdownField(
                        label: 'Gender',
                        hintText: 'Select gender',
                        items: const ['male', 'female'],
                        value: _selectedGender,
                        onChanged: (val) => setState(() => _selectedGender = val),
                        validator: (val) =>
                        val == null ? 'Please select a gender' : null,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Medical History',
                        hintText: 'Enter existing conditions and allergies',
                        controller: _medicalHistoryController,
                        maxLines: 4,
                        validator: (_) => null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Action buttons ────────────────────────────────
                BlocBuilder<DoctorCubit, DoctorState>(
                  builder: (context, state) {
                    final loading = state is DoctorLoading;
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              side: const BorderSide(color: AppColors.border),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: loading
                                ? null
                                : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<DoctorCubit>().addPatient(
                                  name:           _fullNameController.text.trim(),
                                  age:            int.parse(_ageController.text),
                                  gender:         _selectedGender!,
                                  dateOfBirth:    _dobController.text,
                                  nationalId:     _nationalIdController.text.trim(),
                                  medicalHistory: _medicalHistoryController.text.trim().isEmpty
                                      ? null
                                      : _medicalHistoryController.text.trim(),
                                );
                              }
                            },
                            child: loading
                                ? const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                                : Text(
                              'Save',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}