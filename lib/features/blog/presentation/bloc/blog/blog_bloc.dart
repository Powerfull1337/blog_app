import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_by_id.dart';
import 'package:blog_app/features/blog/domain/usecases/get_count_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  final GetAllBlogsById _getAllBlogsById;
  final GetCountBlog _getCountBlog; 
  
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
    required GetAllBlogsById getAllBlogsById,
     required GetCountBlog getCountBlog,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        _getAllBlogsById = getAllBlogsById,
        _getCountBlog = getCountBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
    on<BlogFetchAllBlogsById>(_onFetchAllBlogsById);
    on<BlogFetchCount>(_onFetchCount);
  }

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }
  void _onFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogsDisplaySuccess(r)),
    );
  }
  void _onFetchAllBlogsById(
    BlogFetchAllBlogsById event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogsById(GetAllBlogsByIdParams(userId: event.userId));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogsDisplaySuccess(r)),
    );
  }
  void _onFetchCount(
    BlogFetchCount event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getCountBlog(GetCountBlogParams(userId: event.userId));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogCountSuccess(r)), 
    );
  }
}