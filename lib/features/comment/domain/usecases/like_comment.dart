import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class LikeComment implements UseCase<void, LikeCommentParams> {
  final CommentRepository commentRepository;
  LikeComment(this.commentRepository);

  @override
  Future<Either<Failure, void>> call(LikeCommentParams params) async {
    return await commentRepository.likeComment(
        userId: params.userId, commentId: params.commentId);
  }
}

class LikeCommentParams {
  final String userId;
  final String commentId;

  LikeCommentParams({required this.userId, required this.commentId});
}
