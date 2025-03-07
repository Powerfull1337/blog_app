import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/topics.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.gradient2, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const Text(
            "New games in 2025",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: lisofTopics
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "1 min",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
