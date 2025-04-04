import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog/add_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog/details_blog_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/loader.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/my_blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlogPage extends StatefulWidget {
  const MyBlogPage({super.key});

  @override
  State<MyBlogPage> createState() => _MyBlogPageState();
}

class _MyBlogPageState extends State<MyBlogPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthSuccess) {
        context
            .read<BlogBloc>()
            .add(BlogFetchAllBlogsById(userId: authState.user.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Blogs"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              NavigationService.push(context, const AddBlogPage());
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          } else if (state is BlogLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(12.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1,
              ),
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return MyBlogCard(
                  onTap: () {
                    /// ❗ Спочатку відправляємо подію для отримання лайків
                    context.read<BlogBloc>().add(BlogFetchLikesCount(blogId: blog.id));

                    /// ❗ Використовуємо BlocListener для обробки лайків перед переходом
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return BlocListener<BlogBloc, BlogState>(
                          listener: (context, newState) {
                            if (newState is BlogLoaded) {
                              Navigator.pop(context); // Закриваємо діалог

                              NavigationService.push(
                                context,
                                DetailsBlogPage(
                                  blog: blog,
                                  isLiked: newState.likesCount != null && newState.likesCount! > 0,
                                  likesCount: newState.likesCount ?? 0,
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
            );
          }
          return const Center(child: Text("No blogs available"));
        },
      ),
    );
  }
}
