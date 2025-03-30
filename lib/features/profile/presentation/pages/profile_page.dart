import 'package:blog_app/core/constants/default_images.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/formated_date.dart';
import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/loader.dart';
import 'package:blog_app/features/blog/presentation/pages/blog/my_blog_page.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:blog_app/features/profile/presentation/pages/edit_profile_info_page.dart';
import 'package:blog_app/features/profile/presentation/pages/user_folowed_page.dart';
import 'package:blog_app/features/profile/presentation/pages/user_folowers_page.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  // const CircleAvatar(
                  //   radius: 70,
                  //   backgroundImage:
                  //       AssetImage(DefaultImages.userImage) as ImageProvider,
                  // ),
                  const SizedBox(height: 20),
                  Text(user.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        const TextSpan(text: 'Active Since  -  '),
                        TextSpan(
                          text: formattedByMMMYYYY(user.updatedAt),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigationService.push(context, const MyBlogPage());
                        },
                        child: const Column(
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
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          NavigationService.push(
                              context, const UserFolowersPage());
                        },
                        child: const Column(
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
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          NavigationService.push(
                              context, const UserFolowedPage());
                        },
                        child: const Column(
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Personal Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      GestureDetector(
                        onTap: () {
                          NavigationService.push(
                              context, EditProfileInfoPage(user: user));
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.edit, color: AppColors.blue),
                            SizedBox(width: 5),
                            Text("Edit",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blue)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileTile(
                      titleText: 'Email',
                      icon: Icons.email,
                      sufixWidget: Text(user.email),
                      onTap: () {}),
                  const SizedBox(height: 5),

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
                  const ProfileTile(
                    titleText: 'Settings',
                    icon: FontAwesomeIcons.tools,
                    sufixWidget: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ProfileTile(
                      titleText: 'Logout',
                      icon: Icons.email,
                      sufixWidget: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      ),
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLogout());
                      }),
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
