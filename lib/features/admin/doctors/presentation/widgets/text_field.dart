import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff665F5F),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          width: 340,
          height: 50,
          child: TextFormField(
            controller: controller,
            validator: validator,

            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),

              hintText: hintText,
              hintStyle: TextStyle(
                color: Color(0x66665F5F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xcc474161),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}