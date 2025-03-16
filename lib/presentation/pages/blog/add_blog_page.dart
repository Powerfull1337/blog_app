import 'dart:io';

import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/core/utils/topics.dart';
import 'package:blog_app/presentation/widgets/add_blog_field.dart';
// import 'package:blog_app/presentation/widgets/auth_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedtopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.done))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ))),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        radius: const Radius.circular(16),
                        borderType: BorderType.RRect,
                        color: AppColors.borderColor,
                        dashPattern: const [12, 4],
                        child: const SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 36,
                              ),
                              SizedBox(height: 15),
                              Text("Pick image")
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...listOfTopics.map((e) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                              onTap: () {
                                if (selectedtopics.contains(e)) {
                                  selectedtopics.remove(e);
                                } else {
                                  selectedtopics.add(e);
                                }

                                setState(() {});
                              },
                              child: Chip(
                                  label: Text(e),
                                  color: selectedtopics.contains(e)
                                      ? WidgetStateProperty.all(
                                          AppColors.gradient1)
                                      : null)),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              AddBlogField(
                hintText: "Title",
                controller: titleController,
              ),
              const SizedBox(height: 25),
              AddBlogField(
                hintText: "Content",
                controller: contentController,
              ),
              // const Spacer(),
              // const AuthButton(text: "Add blog"),
              // const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
