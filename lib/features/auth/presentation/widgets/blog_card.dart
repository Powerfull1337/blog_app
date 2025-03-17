import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/topics.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 200,
      width: double.infinity,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const Text(
            "New games in 2025",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: listOfTopics
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(label: Text(e)),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 min",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
              ),
              Text(
                "by Denys",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
