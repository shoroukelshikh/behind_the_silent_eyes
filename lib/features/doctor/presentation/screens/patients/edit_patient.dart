import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/core/widgets/drop_down.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:behind_silent_eyes/features/doctor/presentation/cubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    _fullNameController =
        TextEditingController(text: widget.patient['name']);
    _ageController =
        TextEditingController(text: widget.patient['age']);
    _nationalIdController =
        TextEditingController(text: widget.patient['national_id']);
    _dobController =
        TextEditingController(text: widget.patient['date_of_birth']);
    _medicalHistoryController =
        TextEditingController(text: widget.patient['medical_history']);
    _selectedGender = widget.patient['gender'];
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
            SnackBar(
              content: Text('Patient updated successfully',
                  style: GoogleFonts.poppins(fontSize: 13)),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          Navigator.pop(context);
        }
        if (state is DoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message,
                  style: GoogleFonts.poppins(fontSize: 13)),
              backgroundColor: AppColors.danger,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
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
            'Edit Patient',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Patient avatar header ─────────────────────────
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.accentLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person_rounded,
                            color: AppColors.accent, size: 38),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.patient['name'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Form fields ───────────────────────────────────
                CustomTextField(
                  label: 'Full Name',
                  hintText: 'Please enter the name',
                  controller: _fullNameController,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Name required';
                    if (v.trim().length < 3) return 'Min 3 characters';
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
                    if (v.replaceAll(' ', '').length < 14)
                      return '14 digits required';
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
                      suffixIcon: const Icon(Icons.calendar_today_rounded,
                          color: AppColors.textSecondary, size: 18),
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
                const SizedBox(height: 32),

                // ── Action buttons ────────────────────────────────
                BlocBuilder<DoctorCubit, DoctorState>(
                  builder: (context, state) {
                    final isLoading = state is DoctorLoading;
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.border),
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                              if (_formKey.currentState!.validate()) {
                                final id = int.parse(
                                    widget.patient['id']!);
                                context
                                    .read<DoctorCubit>()
                                    .updatePatient(id, {
                                  'name': _fullNameController.text
                                      .trim(),
                                  'age': int.parse(
                                      _ageController.text),
                                  'gender': _selectedGender!,
                                  'date_of_birth': _dobController.text,
                                  'national_id': _nationalIdController
                                      .text
                                      .trim(),
                                  'medical_history':
                                  _medicalHistoryController.text
                                      .trim(),
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy,
                              foregroundColor: Colors.white,
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                                : Text(
                              'Save Changes',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}