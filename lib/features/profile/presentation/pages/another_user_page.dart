

import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/presentation/widgets/loader.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog/details_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/my_blog_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/follow/follow_bloc.dart';

class AnotherUserPage extends StatefulWidget {
  const AnotherUserPage({super.key, required this.user});

  final User user;

  @override
  State<AnotherUserPage> createState() => _AnotherUserPageState();
}

class _AnotherUserPageState extends State<AnotherUserPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<BlogBloc>()
          .add(BlogFetchAllBlogsById(userId: widget.user.id));

      context
          .read<FollowBloc>()
          .add(CheckIfFollowing(widget.user.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.user.avatarUrl),
                  ),
                  const Expanded(
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
                            Text("Читачів"),
                          ],
                        ),
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
              Text(widget.user.bio,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(color: AppColors.greyColor)),
              const SizedBox(height: 15),

              BlocConsumer<FollowBloc, FollowState>(
                listener: (context, state) {
                  if (state is FollowError) {
                    showSnackBar(context, state.message);
                  } else if (state is FollowActionSuccess) {
                    showSnackBar(context, state.message);
                    context
                        .read<FollowBloc>()
                        .add(CheckIfFollowing(widget.user.id));
                  }
                },
                builder: (context, state) {
                  bool isFollowing = false;
                  if (state is FollowStatus) {
                    isFollowing = state.isFollowing;
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (state is FollowLoading) return;
                            if (isFollowing) {
                              context
                                  .read<FollowBloc>()
                                  .add(UnfollowUser(widget.user.id));
                            } else {
                              context
                                  .read<FollowBloc>()
                                  .add(FollowUser(widget.user.id));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isFollowing
                                  ? Colors.red.withOpacity(0.1)
                                  : AppColors.borderColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is FollowLoading)
                                  const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child:
                                        CircularProgressIndicator(strokeWidth: 2),
                                  )
                                else
                                  Text(isFollowing
                                      ? "Відписатися"
                                      : "Підписатися"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 15),

         
              BlocConsumer<BlogBloc, BlogState>(
                listener: (context, state) {
                  if (state is BlogFailure) {
                    showSnackBar(context, state.error);
                  }
                },
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return const Loader();
                  } else if (state is BlogLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Blogs ${state.blogs.length}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 400,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.blogs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 4.0,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) {
                              final blog = state.blogs[index];
                              return MyBlogCard(
                                onTap: () {
                                  context.read<BlogBloc>().add(
                                      BlogFetchLikesCount(blogId: blog.id));

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return BlocListener<BlogBloc, BlogState>(
                                        listener: (context, newState) {
                                          if (newState is BlogLoaded) {
                                            Navigator.pop(context);
                                            NavigationService.push(
                                              context,
                                              DetailsBlogPage(
                                                blog: blog,
                                                isLiked:
                                                    newState.likesCount != null &&
                                                        newState.likesCount! > 0,
                                                likesCount:
                                                    newState.likesCount ?? 0,
                                              ),
                                            );
                                          }
                                        },
                                        child: const Center(child: Loader()),
                                      );
                                    },
                                  );
                                },
                                title: blog.title,
                                imageUrl: blog.imageUrl,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
