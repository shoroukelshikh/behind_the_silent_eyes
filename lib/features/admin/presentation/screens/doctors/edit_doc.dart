import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:behind_silent_eyes/features/admin/domain/entities/doctor_entity.dart';
import 'package:behind_silent_eyes/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:behind_silent_eyes/features/admin/presentation/cubit/admin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/text_field.dart';

class EditDoc extends StatefulWidget {
  final DoctorEntity doctor;

  const EditDoc({super.key, required this.doctor});

  @override
  State<EditDoc> createState() => _EditDocState();
}

class _EditDocState extends State<EditDoc> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nameController;
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _codeController =
        TextEditingController(text: widget.doctor.doctorCode ?? '');
    _emailController = TextEditingController(text: widget.doctor.email);
    _phoneController = TextEditingController(text: widget.doctor.phone ?? '');
    _nameController = TextEditingController(text: widget.doctor.name);
  }

  @override
  void dispose() {
    _codeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AdminCubit>().updateDoctor(
        id: widget.doctor.id,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        doctorCode: _codeController.text.trim(),
        password: _passwordController.text.isNotEmpty
            ? _passwordController.text
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DoctorActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Doctor updated successfully',
                  style: GoogleFonts.poppins(fontSize: 13)),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AdminFailure) {
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
            'Edit doctor',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            final isLoading = state is AdminLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ──────────────────────────────────
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.accentLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_rounded,
                              color: AppColors.accent, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctor.name,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              widget.doctor.doctorCode ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 20),

                    // ── Fields ──────────────────────────────────
                    CustomTextField(
                      label: 'Doctor code',
                      hintText: 'e.g. DOC-0001',
                      controller: _codeController,
                      validator: (v) =>
                      (v == null || v.isEmpty) ? 'Code required' : null,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: 'Full name',
                      hintText: 'Enter full name',
                      controller: _nameController,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty)
                          return 'Name is required';
                        if (v.trim().length < 3)
                          return 'Name must be at least 3 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: 'Email',
                      hintText: 'doctor@example.com',
                      controller: _emailController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email required';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: 'Phone',
                      hintText: '01XXXXXXXXX',
                      controller: _phoneController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Phone required';
                        if (v.length < 10) return 'Min 10 digits';
                        if (!RegExp(r'^[0-9]+$').hasMatch(v))
                          return 'Digits only';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: 'New password',
                      hintText: 'Leave blank to keep current',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (v) {
                        if (v != null && v.isNotEmpty && v.length < 6)
                          return 'Min 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 36),

                    // ── Buttons ─────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.navy,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isLoading ? null : _submit,
                              child: isLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : Text(
                                'Save changes',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textSecondary,
                                side: const BorderSide(
                                    color: AppColors.borderDark),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
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