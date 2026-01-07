
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final TextInputType keyboard;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.isPassword,
    this.keyboard = TextInputType.text,
    this.validator,
  });


@override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboard,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
      decoration: InputDecoration(
  labelText: label,
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.grey.shade300),
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: Color(0xFF6A5AE0),
      width: 2,
    ),
  ),
),
    );
  }
}
Widget _buildTextField(TextEditingController controller, String label, bool isPassword,
      {TextInputType keyboard = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboard,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
      decoration: InputDecoration(
  labelText: label,
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.grey.shade300),
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: Color(0xFF6A5AE0),
      width: 2,
    ),
  ),
),
    );
  }









