import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/core/utils/topics.dart';
import 'package:blog_app/features/auth/presentation/pages/blog/blog_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/add_blog_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/loader.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog/blog_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void uploadBlog() async {
    if (selectedTopics.isNotEmpty && image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
              posterId: posterId,
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              image: image!,
              topics: selectedTopics,
            ),
          );
    }
  }

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
        actions: [
          IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogSuccess) {
            NavigationService.pushAndRemoveUntil(context, const BlogPage());
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
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
                                    if (selectedTopics.contains(e)) {
                                      selectedTopics.remove(e);
                                    } else {
                                      selectedTopics.add(e);
                                    }

                                    setState(() {});
                                  },
                                  child: Chip(
                                      label: Text(e),
                                      color: selectedTopics.contains(e)
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
          );
        },
      ),
    );
  }
}
