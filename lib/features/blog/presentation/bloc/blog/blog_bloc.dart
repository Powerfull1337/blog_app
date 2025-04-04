import 'dart:io';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_by_id.dart';
import 'package:blog_app/features/blog/domain/usecases/get_blog_likes.dart';
import 'package:blog_app/features/blog/domain/usecases/get_count_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/like_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/unlike_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  //final GetAllBlogs _getAllBlogs;
  final GetAllBlogsById _getAllBlogsById;
  final GetCountBlog _getCountBlog;
  final LikeBlog _likeBlog;
  final UnlikeBlog _unlikeBlog;
  final GetBlogLikes _getBlogLikesCount;

  BlogBloc({
    required UploadBlog uploadBlog,
  //  required GetAllBlogs getAllBlogs,
    required GetAllBlogsById getAllBlogsById,
    required GetCountBlog getCountBlog,
    required LikeBlog likeBlog,
    required UnlikeBlog unlikeBlog,
    required GetBlogLikes getBlogLikesCount,
  })  : _uploadBlog = uploadBlog,
    //    _getAllBlogs = getAllBlogs,
        _getAllBlogsById = getAllBlogsById,
        _getCountBlog = getCountBlog,
        _likeBlog = likeBlog,
        _unlikeBlog = unlikeBlog,
        _getBlogLikesCount = getBlogLikesCount,
        super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
 //   on<BlogFetchAllBlogs>(_onFetchAllBlogs);
    on<BlogFetchAllBlogsById>(_onFetchAllBlogsById);
    on<BlogFetchCount>(_onFetchCount);
    on<BlogLike>(_onBlogLike);
    on<BlogUnlike>(_onBlogUnlike);
    on<BlogFetchLikesCount>(_onFetchLikesCount);
  }

  
  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await _uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  // Future<void> _onFetchAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
  //   emit(BlogLoading());
  //   final res = await _getAllBlogs(NoParams());

  //   res.fold(
  //     (l) => emit(BlogFailure(l.message)),
  //     (r) {
  //       final currentState = state is BlogLoaded ? state as BlogLoaded : null;
  //       emit(BlogLoaded(
  //         blogs: r,
  //         blogCount: currentState?.blogCount,
  //         likesCount: currentState?.likesCount,
  //       ));
  //     },
  //   );
  // }

  Future<void> _onFetchAllBlogsById(BlogFetchAllBlogsById event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await _getAllBlogsById(GetAllBlogsByIdParams(userId: event.userId));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) {
        final currentState = state is BlogLoaded ? state as BlogLoaded : null;
        emit(BlogLoaded(
          blogs: r,
          blogCount: currentState?.blogCount,
          likesCount: currentState?.likesCount,
        ));
      },
    );
  }

  Future<void> _onFetchCount(BlogFetchCount event, Emitter<BlogState> emit) async {
    final res = await _getCountBlog(GetCountBlogParams(userId: event.userId));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) {
        final currentState = state is BlogLoaded ? state as BlogLoaded : null;
        emit(currentState!.copyWith(blogCount: r));
      },
    );
  }

  Future<void> _onBlogLike(BlogLike event, Emitter<BlogState> emit) async {
    final res = await _likeBlog(LikeBlogParams(blogId: event.blogId, userId: event.userId));

    await res.fold(
      (l) async => emit(BlogFailure(l.message)),
      (r) async {
        final countRes = await _getBlogLikesCount(GetBlogLikesParams(blogId: event.blogId));
        countRes.fold(
          (l) => emit(BlogFailure(l.message)),
          (likesCount) {
            final currentState = state as BlogLoaded?;
            emit(currentState!.copyWith(likesCount: likesCount));
          },
        );
      },
    );
  }

  Future<void> _onBlogUnlike(BlogUnlike event, Emitter<BlogState> emit) async {
    final res = await _unlikeBlog(UnlikeBlogParams(blogId: event.blogId, userId: event.userId));

    await res.fold(
      (l) async => emit(BlogFailure(l.message)),
      (r) async {
        final countRes = await _getBlogLikesCount(GetBlogLikesParams(blogId: event.blogId));
        countRes.fold(
          (l) => emit(BlogFailure(l.message)),
          (likesCount) {
            final currentState = state as BlogLoaded?;
            emit(currentState!.copyWith(likesCount: likesCount));
          },
        );
      },
    );
  }

  Future<void> _onFetchLikesCount(BlogFetchLikesCount event, Emitter<BlogState> emit) async {
    final res = await _getBlogLikesCount(GetBlogLikesParams(blogId: event.blogId));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) {
        final currentState = state as BlogLoaded?;
        emit(currentState!.copyWith(likesCount: r));
      },
    );
  }
}
