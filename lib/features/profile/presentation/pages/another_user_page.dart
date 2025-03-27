import 'package:blog_app/core/constants/default_images.dart';
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
