import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/presentation/blog/add_blog_page.dart';
import 'package:blog_app/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog App"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  NavigationService.push(context, const AddBlogPage());
                },
                icon: const Icon(CupertinoIcons.add))
          ],
        ),
        body: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return BlogCard(
                  color: index % 2 == 0
                      ? AppColors.gradient1
                      : AppColors.gradient3);
            }));
  }
}
