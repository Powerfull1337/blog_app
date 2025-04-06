import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/like/like_bloc.dart';
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
  late String userId;

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      userId = authState.user.id;

      /// Ініціалізуємо початковий стан для LikeBloc
      context.read<LikeBloc>().add(
            InitializeLikeStateEvent(
              isLiked: widget.isLiked,
              likesCount: widget.likesCount,
            ),
          );

      /// Після цього отримуємо оновлену інфу з бекенду
      context.read<LikeBloc>().add(
            CheckIfBlogLikedEvent(blogId: widget.blog.id, userId: userId),
          );
      context.read<LikeBloc>().add(
            GetLikesCountEvent(blogId: widget.blog.id),
          );
    }
  }

  void _onLikePressed(bool isLiked) {
    if (isLiked) {
      context.read<LikeBloc>().add(
            UnlikeBlogEvent(blogId: widget.blog.id, userId: userId),
          );
    } else {
      context.read<LikeBloc>().add(
            LikeBlogEvent(blogId: widget.blog.id, userId: userId),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<LikeBloc, LikeState>(
            builder: (context, state) {
              final isLiked = state.isLiked;
              final likesCount = state.likesCount;

              return Row(
                children: [
                  IconButton(
                    onPressed: () => _onLikePressed(isLiked),
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
              );
            },
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
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
