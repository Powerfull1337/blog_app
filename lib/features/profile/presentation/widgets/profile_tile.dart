import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key,
      this.onTap,
      required this.titleText,
      required this.icon,
      required this.sufixWidget});

  final Function()? onTap;
  final String titleText;
  final IconData icon;
  final Widget sufixWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.darkBlue, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(titleText),
              ],
            ),
            sufixWidget
          ],
        ),
      ),
    );
  }
}
