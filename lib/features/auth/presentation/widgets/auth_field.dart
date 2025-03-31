import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.maxLength, this.maxLines,
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        counterStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
