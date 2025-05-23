import 'dart:developer';
import 'dart:io';


import 'package:blog_app/core/constants/message_constants.dart';
import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource, this.connectionChecker,
      this.blogLocalDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(MessageConstants.noInternetConnection));
      }
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now());

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          blog: blogModel, image: image);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<Blog>>> getAllBlogs() async {
  //   try {
  //     if (!await (connectionChecker.isConnected)) {
  //       final blogs = await blogLocalDataSource.loadBlogs();
  //       return right(blogs);
  //     }

  //     final blogs = await blogRemoteDataSource.getAllBlogs();
  //     blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
  //     return right(blogs);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogsById(
      {required String userId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = await blogLocalDataSource.loadBlogs();
        return right(blogs);
      }

      final blogs = await blogRemoteDataSource.getAllBlogsById(userId);
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getCountBlog({required String userId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(MessageConstants.noInternetConnection));
      }
      final count = await blogRemoteDataSource.getCountBlog(userId);
      log("Fetched count: $count");
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

   @override
  Future<Either<Failure, void>> likeBlog({required String blogId, required String userId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(MessageConstants.noInternetConnection));
      }
      await blogRemoteDataSource.likeBlog(blogId, userId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlikeBlog({required String blogId, required String userId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(MessageConstants.noInternetConnection));
      }
      await blogRemoteDataSource.unlikeBlog(blogId, userId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isBlogLikedByUser({required String blogId, required String userId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(MessageConstants.noInternetConnection));
      }
      final isLiked = await blogRemoteDataSource.isBlogLikedByUser(blogId, userId);
      return right(isLiked);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getBlogLikesCount({required String blogId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(MessageConstants.noInternetConnection));
      }
      final count = await blogRemoteDataSource.getBlogLikesCount(blogId);
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
