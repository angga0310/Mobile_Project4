import 'package:flutter/material.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextFieldPassword({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.validator
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
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
          prefixIcon: Icon(widget.prefixIcon, color: Color.fromARGB(1000, 96, 96, 96)),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
    );
  }
}
