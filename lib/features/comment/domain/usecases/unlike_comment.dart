import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class UnLikeComment implements UseCase<void, UnLikeCommentParams> {
  final CommentRepository commentRepository;
  UnLikeComment(this.commentRepository);

  @override
  Future<Either<Failure, void>> call(UnLikeCommentParams params) async {
    return await commentRepository.unLikeComment(
        userId: params.userId, commentId: params.commentId);
  }
}

class UnLikeCommentParams {
  final String userId;
  final String commentId;

  UnLikeCommentParams({required this.userId, required this.commentId});
}
