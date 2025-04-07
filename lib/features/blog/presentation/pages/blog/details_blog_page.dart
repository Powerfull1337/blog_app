import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/formated_date.dart';
import 'package:blog_app/core/utils/reading_time.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/like/like_bloc.dart';
import 'package:blog_app/features/comment/presentation/bloc/comments/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

      context.read<LikeBloc>().add(
            InitializeLikeStateEvent(
              isLiked: widget.isLiked,
              likesCount: widget.likesCount,
            ),
          );

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

  void showModalCommentsBottomSheet(
      BuildContext context, String blogId, String userId) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Коментарі",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(color: AppColors.greyColor),
                  Expanded(
                    child: BlocBuilder<CommentsBloc, CommentsState>(
                      builder: (context, state) {
                        if (state is CommentsLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is CommentsLoaded) {
                          final comments = state.comments;
                          return ListView.builder(
                            controller: scrollController,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.greyColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          comment.userAvatar ?? ""),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                comment.userName ?? "Анонім",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(width: 30),
                                              Text(
                                                formattedByDMMMYYYY(
                                                    comment.createdAt),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            comment.content,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (state is CommentsError) {
                          return Center(
                              child: Text("Помилка: ${state.message}"));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: "Напишіть коментар...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            final text = commentController.text.trim();
                            if (text.isNotEmpty) {
                              context.read<CommentsBloc>().add(
                                    UploadCommentEvent(
                                      blogId: blogId,
                                      userId: userId,
                                      content: text,
                                    ),
                                  );
                              commentController.clear();
                            }
                          },
                          icon: const Icon(Icons.send, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    context.read<CommentsBloc>().add(FetchCommentsEvent(blogId: blogId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.blog.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "By ${widget.blog.posterName}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  formattedByDMMMYYYY(widget.blog.updatedAt),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
                const SizedBox(width: 5),
                const Text(
                  ".",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
                const SizedBox(width: 5),
                Text(
                  "${calculateReadingTime(widget.blog.content).toString()} min",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.blog.imageUrl,
                      fit: BoxFit.cover,
                    ))),
            const SizedBox(height: 30),
            Text(
              widget.blog.content,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<LikeBloc, LikeState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () => _onLikePressed(state.isLiked),
                            icon: Icon(
                              state.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: state.isLiked ? Colors.red : null,
                            ),
                          ),
                          Text(
                            state.likesCount.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalCommentsBottomSheet(
                              context, widget.blog.id, userId);
                        },
                        icon: const FaIcon(FontAwesomeIcons.comment),
                      ),
                      const Text("Коментарі", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
