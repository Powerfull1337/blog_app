import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/navigation_service.dart';
import 'package:blog_app/core/utils/reading_time.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/presentation/pages/blog/add_blog_page.dart';
import 'package:blog_app/features/auth/presentation/pages/blog/details_blog_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/blog_card.dart';
import 'package:blog_app/features/auth/presentation/widgets/loader.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog/blog_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog App"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  NavigationService.push(context, const AddBlogPage());
                },
                icon: const Icon(CupertinoIcons.add))
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
            } else if (state is BlogsDisplaySuccess) {
              return ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return BlogCard(
                      onTap: (){
                        NavigationService.push(context, DetailsBlogPage(blog: blog));
                      },
                      color: index % 2 == 0
                          ? AppColors.gradient1
                          : AppColors.gradient3,
                      title: blog.title,
                      topics: blog.topics,
                      posterName: blog.posterName!,
                      readingTime:
                          calculateReadingTime(blog.content).toString(),
                    );
                  });
            }
            return const SizedBox();
          },
        ));
  }
}
