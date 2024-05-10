import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color.fromARGB(1000, 96, 96, 96),
          ),
          hintStyle: const TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color.fromARGB(1000, 96, 96, 96),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xFF606060),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(prefixIcon, color: Color.fromARGB(1000, 96, 96, 96)),
        ),
      );
  }
}
