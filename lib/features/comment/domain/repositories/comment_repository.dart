import 'package:blog_app/core/errors/failures.dart';

import 'package:blog_app/features/comment/domain/entities/comment.dart';
import 'package:fpdart/fpdart.dart';

abstract class CommentRepository {
  Future<Either<Failure, Comment>> uploadComment({
    required String blogId,
    required String userId,
    required String content,
  });

  Future<Either<Failure, List<Comment>>> getAllCommentsByBlog(
      {required String blogId});

  Future<Either<Failure, void>> likeComment(
      {required String commentId, required String userId});
  Future<Either<Failure, void>> unLikeComment(
      {required String commentId, required String userId});

  Future<Either<Failure, bool>> isCommentLikedByUser(
      {required String commentId, required String userId});

  Future<Either<Failure, int>> getCommentLikesCount({required String commentId});
}
