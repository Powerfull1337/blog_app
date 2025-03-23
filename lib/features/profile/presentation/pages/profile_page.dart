import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/presentation/widgets/loader.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchUserInformation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Widget defaultHeightSizedBox = SizedBox(height: 5);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Loader();
          } else if (state is ProfileLoaded) {
            final user = state.user;
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.red,
                  ),
                  const SizedBox(height: 20),
                  Text(user.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(text: 'Active Since  -  '),
                        TextSpan(
                          text: 'Jul, 2019',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Personal Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      Row(
                        children: [
                          Icon(Icons.edit, color: AppColors.blue),
                          SizedBox(width: 5),
                          Text("Edit",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileTile(
                      titleText: 'Email',
                      icon: Icons.email,
                      sufixWidget: Text(user.email),
                      onTap: () {}),
                  defaultHeightSizedBox,
                  ProfileTile(
                      titleText: 'Folowers',
                      icon: Icons.person,
                      sufixWidget: const Text("342"),
                      onTap: () {}),
                  defaultHeightSizedBox,
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Utilities",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileTile(
                      titleText: 'Logout',
                      icon: Icons.email,
                      sufixWidget: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      ),
                      onTap: () {}),
                  defaultHeightSizedBox,
                ],
              ),
            ));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
