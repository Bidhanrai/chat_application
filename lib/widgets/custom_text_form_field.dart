import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  const CustomTextFormField({super.key, this.hintText, this.controller, this.validator, this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 0.3),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
