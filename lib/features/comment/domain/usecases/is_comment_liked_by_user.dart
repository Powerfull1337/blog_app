import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';

import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class IsCommentBlogLikedByUser
    implements UseCase<bool, IsCommentBlogLikedByUserParams> {
  final CommentRepository commentRepository;
  IsCommentBlogLikedByUser(this.commentRepository);

  @override
  Future<Either<Failure, bool>> call(
      IsCommentBlogLikedByUserParams params) async {
    return await commentRepository.isCommentLikedByUser(
      userId: params.userId,
      commentId: params.commentId,
    );
  }
}

class IsCommentBlogLikedByUserParams {
  final String userId;
  final String commentId;

  IsCommentBlogLikedByUserParams(
      {required this.userId, required this.commentId});
}
