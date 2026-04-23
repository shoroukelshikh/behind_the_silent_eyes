import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../admin/presentation/widgets/text_field.dart';

class EditProf extends StatefulWidget {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const EditProf({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password
  });

  @override
  State<EditProf> createState() => _EditProfState();
}

class _EditProfState extends State<EditProf> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;


  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.fullName);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    passwordController = TextEditingController(text: widget.password);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.primary),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              
                  const SizedBox(height: 200),
              
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
                    controller: nameController,
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
                    return null;}
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
                            backgroundColor: const Color(0xcc474161),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Profile updated successfully"),
                                ),
                              );
                              // Future.delayed(const Duration(milliseconds: 500), () {
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => DocList(),
                              //     ),
                              //   );
                              // });
                            }
                          },
                          child: const Text('Update'),
                        ),
                      ),
              
                      const SizedBox(width: 16),
              
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xcc474161),
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
      ),
    );
  }
}
