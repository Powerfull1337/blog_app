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
  Future<Either<Failure, int>> getCommentLikesCount(String commentId) {
    // TODO: implement getCommentLikesCount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> isCommentLikedByUser(
      String commentId, String userId) {
    // TODO: implement isCommentLikedByUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> likeComment(
      {required String commentId, required String userId}) {
    // TODO: implement likeComment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> unLikeComment(
      {required String commentId, required String userId}) {
    // TODO: implement unLikeComment
    throw UnimplementedError();
  }
}
