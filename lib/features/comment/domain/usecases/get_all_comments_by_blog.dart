import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/comment/domain/entities/comment.dart';
import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllCommentByBlog
    implements UseCase<List<Comment>, GetAllCommentByBlogParams> {
  final CommentRepository commentRepository;
  GetAllCommentByBlog(this.commentRepository);

  @override
  Future<Either<Failure, List<Comment>>> call(
      GetAllCommentByBlogParams params) async {
    return await commentRepository.getAllCommentsByBlog(blogId: params.blogId);
  }
}

class GetAllCommentByBlogParams {
  final String blogId;

  GetAllCommentByBlogParams({required this.blogId});
}
