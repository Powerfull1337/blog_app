
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsBlogPage extends StatefulWidget {
  const DetailsBlogPage({
    super.key,
    required this.blog,
    required this.isLiked,
    required this.likesCount,
  });

  final Blog blog;
  final bool isLiked;
  final int likesCount;

  @override
  State<DetailsBlogPage> createState() => _DetailsBlogPageState();
}

class _DetailsBlogPageState extends State<DetailsBlogPage> {
  late bool isLiked;
  late int likesCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likesCount = widget.likesCount;
  }

  void toggleLike() {
    final blogBloc = context.read<BlogBloc>();
    final userState = context.read<AuthBloc>().state;

    if (userState is AuthSuccess) {
      final userId = userState.user.id;

      setState(() {
        isLiked = !isLiked;
        likesCount = isLiked ? likesCount + 1 : likesCount - 1;
      });

      if (isLiked) {
        blogBloc.add(BlogLike(blogId: widget.blog.id, userId: userId));
      } else {
        blogBloc.add(BlogUnlike(blogId: widget.blog.id, userId: userId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: toggleLike,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : null,
                ),
              ),
              Text(
                likesCount.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              widget.blog.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "By ${widget.blog.posterName}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(widget.blog.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              widget.blog.content,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
