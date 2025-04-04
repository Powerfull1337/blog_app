


import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UnlikeBlog implements UseCase<void, UnlikeBlogParams> {
  final BlogRepository blogRepository;
  UnlikeBlog(this.blogRepository);

  @override
  Future<Either<Failure, void>> call(UnlikeBlogParams params) async {
    return await blogRepository.unlikeBlog(blogId: params.blogId, userId: params.userId);
  }
}

class UnlikeBlogParams {
  final String userId;
  final String blogId;

  UnlikeBlogParams({required this.userId, required this.blogId});
}
