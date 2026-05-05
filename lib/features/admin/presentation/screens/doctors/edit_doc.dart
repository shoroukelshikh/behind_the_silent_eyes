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
            const SnackBar(
              content: Text('Doctor updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AdminFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color(0xff665F5F), size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: AppColors.primary),
          child: BlocBuilder<AdminCubit, AdminState>(
            builder: (context, state) {
              final isLoading = state is AdminLoading;
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Edit Doctor Information',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: const Color(0xff665F5F),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      CustomTextField(
                        label: 'Doctor Code',
                        hintText: 'e.g. DOC-0001',
                        controller: _codeController,
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Code required' : null,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        label: 'Full Name',
                        hintText: 'Enter full name',
                        controller: _nameController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Name is required';
                          }
                          if (v.trim().length < 3) {
                            return 'Name must be at least 3 characters';
                          }
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
                          if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                            return 'Digits only';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        label: 'New Password (leave blank to keep current)',
                        hintText: 'Min 6 characters',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                        ),
                        validator: (v) {
                          if (v != null && v.isNotEmpty && v.length < 6) {
                            return 'Min 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xcc474161),
                                foregroundColor: Colors.white,
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                  : const Text('Update'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xcc474161),
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Color(0xcc474161)),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
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
      ),
    );
  }
}