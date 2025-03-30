import 'dart:io';

import 'package:blog_app/core/constants/default_images.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileInfoPage extends StatefulWidget {
  const EditProfileInfoPage({super.key, required this.user});

  final User user;

  @override
  State<EditProfileInfoPage> createState() => _EditProfileInfoPageState();
}

class _EditProfileInfoPageState extends State<EditProfileInfoPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  File? image;
  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

void updateUserInfo() {
  final newName = nameController.text.trim();
  final isNameChanged = newName != widget.user.name;
  final isImageChanged = image != null;

  if (!isNameChanged && !isImageChanged) {
    Navigator.pop(context); 
    return;
  }

  context.read<ProfileBloc>().add(UpdateUserInformation(
    name: isNameChanged ? newName : null,
    image: isImageChanged ? image : null,
  ));

  Navigator.pop(context);
}


  @override
  void initState() {
    nameController.text = widget.user.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile Info",
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  updateUserInfo();
                },
                icon: const Icon(Icons.done))
          ],
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: selectImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: image != null
                                  ? FileImage(image!)
                                  : NetworkImage(widget.user.avatarUrl),
                            ),
                            // CircleAvatar(
                            //   radius: 70,
                            //   backgroundImage:
                            //       AssetImage(DefaultImages.userImage)
                            //           as ImageProvider,
                            // ),
                            const Positioned(
                                bottom: 5,
                                right: 5,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: AppColors.blue,
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.whiteColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      AuthField(
                        hintText: "Name",
                        controller: nameController,
                      ),
                      const SizedBox(height: 20),
                      AuthField(
                        hintText: "Password",
                        controller: nameController,
                        obscureText: true,
                      ),
                    ]))));
  }
}
