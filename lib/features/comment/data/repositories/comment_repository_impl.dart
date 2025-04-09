import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/features/comment/data/datasource/comment_remote_data_source.dart';
import 'package:blog_app/features/comment/data/models/comment_model.dart';
import 'package:blog_app/features/comment/domain/entities/comment.dart';
import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRepositoryImpl(this.commentRemoteDataSource);

  @override
  Future<Either<Failure, Comment>> uploadComment(
      {required String blogId,
      required String userId,
      required String content}) async {
    try {
      CommentModel commentModel = CommentModel(
          id: const Uuid().v1(),
          blogId: blogId,
          userId: userId,
          content: content,
          createdAt: DateTime.now());

      final uploadComment =
          await commentRemoteDataSource.uploadComment(commentModel);

      return right(uploadComment);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllCommentsByBlog(
      {required String blogId}) async {
    try {
      final comments =
          await commentRemoteDataSource.getAllCommentsByBlog(blogId);
      return right(comments);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeComment({
    required String commentId,
    required String userId,
  }) async {
    try {
      await commentRemoteDataSource.likeComment(commentId, userId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unLikeComment({
    required String commentId,
    required String userId,
  }) async {
    try {
      await commentRemoteDataSource.unlikeComment(commentId, userId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getCommentLikesCount({
    required String commentId,
  }) async {
    try {
      final count =
          await commentRemoteDataSource.getCommentLikesCount(commentId);
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isCommentLikedByUser({
    required String commentId,
    required String userId,
  }) async {
    try {
      final isLiked =
          await commentRemoteDataSource.isCommentLikedByUser(commentId, userId);
      return right(isLiked);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
