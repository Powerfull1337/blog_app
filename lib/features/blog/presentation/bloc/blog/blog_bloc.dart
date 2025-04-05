import 'dart:io';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_by_id.dart';
import 'package:blog_app/features/blog/domain/usecases/get_count_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogsById _getAllBlogsById;
  final GetCountBlog _getCountBlog;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogsById getAllBlogsById,
    required GetCountBlog getCountBlog,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogsById = getAllBlogsById,
        _getCountBlog = getCountBlog,
        super(BlogInitial()) {
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogsById>(_onFetchAllBlogsById);
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
        ));
      },
    );
  }
}
