import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DatePickerField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final DateTime? initialDate;
  final void Function(DateTime?) onDateSelected;
  final TextEditingController controller;

  const DatePickerField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.initialDate,
    required this.onDateSelected,
    required this.controller,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(_selectedDate),
      ),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null && pickedDate != _selectedDate) {
          setState(() {
            _selectedDate = pickedDate;
            widget.onDateSelected(pickedDate);
          });
        }
      },
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
      ),
    );
  }
}
