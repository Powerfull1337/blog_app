
import 'package:flutter/material.dart';

class MyBlogCard extends StatelessWidget {
  final String title;

  final String imageUrl;

  final Function()? onTap;

  const MyBlogCard({
    super.key,
    required this.title,
    this.onTap,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        // child: Container(
        //   decoration: BoxDecoration(
        //     color: AppColors.whiteColor,
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            //   child: Text(
            //     title,
            //     style: const TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: AppColors.borderColor,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     bottomLeft: Radius.circular(12),
            //     bottomRight: Radius.circular(12),
            //   ),
            //   child:
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.image_not_supported));
              },
            ),
          ],
        ));
  }
}
