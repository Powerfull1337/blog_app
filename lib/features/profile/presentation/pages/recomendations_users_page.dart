import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/presentation/widgets/loader.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:blog_app/features/profile/presentation/pages/another_user_page.dart';
import 'package:blog_app/features/profile/presentation/widgets/folowers_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecomendationsUsersPage extends StatefulWidget {
  const RecomendationsUsersPage({super.key});

  @override
  State<RecomendationsUsersPage> createState() => _RecomendationsUsersPageState();
}

class _RecomendationsUsersPageState extends State<RecomendationsUsersPage> {


  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchAllUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recomendations"),
        actions: const [],
        centerTitle: true,
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
          } else if (state is UsersLoaded) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return FolowersCard(
                    avatarUrl: user.avatarUrl,
                    name: user.name,
                    sufixWidget: const Text(
                      "View",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyColor),
                    ),
                    onTap: () {
                      NavigationService.push(context,  AnotherUserPage(user: user,));
                    },
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
