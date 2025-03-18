import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Color color;
  final String title;
  final String posterName;
  final String readingTime;
  final List<String> topics;

  const BlogCard(
      {super.key,
      required this.color,
      required this.title,
      required this.topics,
      required this.posterName, required this.readingTime});

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
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: topics
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                readingTime,
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
              ),
              Text(
                posterName,
                style:
                    const TextStyle(color: AppColors.whiteColor, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
