import 'package:blog_app/core/constants/default_images.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/profile/presentation/widgets/user_blog_card.dart';
import 'package:flutter/material.dart';

class AnotherUserPage extends StatelessWidget {
  const AnotherUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UserName"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              const Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage(DefaultImages.userImage) as ImageProvider,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text("Блогів"),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text("Читачів"),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text("Відстежує"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: AppColors.greyColor)),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return const UserBlogCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
