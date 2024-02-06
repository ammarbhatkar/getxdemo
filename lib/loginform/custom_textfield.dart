import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.inputFormatters,
      this.validator,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(hintText: hintText),
      onChanged: onChange,
    );
  }
}
