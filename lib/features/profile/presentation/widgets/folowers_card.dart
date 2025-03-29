import 'package:blog_app/core/constants/default_images.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FolowersCard extends StatelessWidget {
  const FolowersCard({super.key, this.onTap, required this.sufixWidget});
  final Function()? onTap;
  final Widget sufixWidget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.darkBrown, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage(DefaultImages.userImage) as ImageProvider,
                ),
                SizedBox(width: 15),
                Text(
                  "Egor & Dima",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            sufixWidget
          ],
        ),
      ),
    );
  }
}
