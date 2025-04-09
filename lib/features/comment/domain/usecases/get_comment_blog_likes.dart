import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCommentBlogLikes implements UseCase<int, GetCommentBlogLikesParams> {
  final CommentRepository commentRepository;
  GetCommentBlogLikes(this.commentRepository);

  @override
  Future<Either<Failure, int>> call(GetCommentBlogLikesParams params) async {
    return await commentRepository.getCommentLikesCount(
        commentId: params.commentId);
  }
}

class GetCommentBlogLikesParams {
  final String commentId;

  GetCommentBlogLikesParams({required this.commentId});
}
