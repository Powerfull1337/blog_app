//import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddBlogField extends StatelessWidget {
  const AddBlogField({super.key, required this.hintText, this.controller});

  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        // border: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(12)),
        //   borderSide: BorderSide(
        //     color: AppColors.gradient1,
        //     width: 3,
        //   ),
        // ),
      ),
      maxLines: null,
    );
  }
}
