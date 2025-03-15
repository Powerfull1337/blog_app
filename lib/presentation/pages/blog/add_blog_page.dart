import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatelessWidget {
  const AddBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DottedBorder(
              child: const SizedBox(
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 32,
                    ),
                    SizedBox(height: 20),
                    Text("Pick image")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
