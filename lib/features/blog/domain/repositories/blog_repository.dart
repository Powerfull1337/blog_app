import 'dart:io';

import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  //Future<Either<Failure, List<Blog>>> getAllBlogs();
  Future<Either<Failure, List<Blog>>> getAllBlogsById({required String userId});

  Future<Either<Failure, int>> getCountBlog({required String userId});

  Future<Either<Failure, void>> likeBlog({required String blogId, required String userId});
  Future<Either<Failure, void>> unlikeBlog({required String blogId, required String userId});
  Future<Either<Failure, bool>> isBlogLikedByUser({required String blogId, required String userId});
  Future<Either<Failure, int>> getBlogLikesCount({required String blogId});
}
