import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/comment/domain/entities/comment.dart';
import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadComment implements UseCase<Comment, UploadCommentParams> {
  final CommentRepository commentRepository;
  UploadComment(this.commentRepository);

  @override
  Future<Either<Failure, Comment>> call(UploadCommentParams params) async {
    return await commentRepository.uploadComment(
      content: params.content,
      blogId: params.blogId,
      userId: params.userId,
    );
  }
}

class UploadCommentParams {
  final String blogId;
  final String userId;
  final String content;

  UploadCommentParams({
    required this.blogId,
    required this.userId,
    required this.content,
  });
}
