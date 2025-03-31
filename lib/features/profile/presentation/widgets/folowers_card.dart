import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FolowersCard extends StatelessWidget {
  const FolowersCard(
      {super.key,
      this.onTap,
      required this.sufixWidget,
      required this.name,
      required this.avatarUrl});
  final Function()? onTap;
  final Widget sufixWidget;
  final String name;
  final String avatarUrl;

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
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 15),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
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
