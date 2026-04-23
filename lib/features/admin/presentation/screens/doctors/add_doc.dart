import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_field.dart';

class AddDoc extends StatefulWidget {
  const AddDoc({super.key});

  @override
  State<AddDoc> createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff665F5F),
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            100,
            16,
            16,
          ), // 100 for spacing from top
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Fill in the doctor information bellow ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff665F5F),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Doctor code',
                  hintText: 'Please enter the code',
                  controller: codeController,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Code required' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Email',
                  hintText: 'please enter the Email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email required';
                    if (!value.contains('@')) return 'Enter valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Phone',
                  hintText: 'Please enter the phone',
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone required';
                    }
                    if (value.length < 11) {
                      return 'Min 11 chars';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Phone number must contain digits only";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Full Name',
                  hintText: 'Please enter the Full name',
                  controller: fullNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name is required";
                    }

                    if (value.trim().length < 8) {
                      return "Name must be at least 8 characters";
                    }

                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return "Name must contain letters only";
                    }

                    return null; // valid
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Password',
                  hintText: 'Please enter the Password',
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password required';
                    }
                    if (value.length < 6) return 'Min 6 chars';
                    return null;
                  },
                ),
                SizedBox(height: 200),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xcc474161),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Saved successfully'),
                              ),
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          codeController.clear();
                          emailController.clear();
                          phoneController.clear();
                          fullNameController.clear();
                          passwordController.clear();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xcc474161),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
