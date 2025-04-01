import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsById implements UseCase<List<Blog>, GetAllBlogsByIdParams> {
  final BlogRepository blogRepository;
  GetAllBlogsById(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(GetAllBlogsByIdParams params) async {
    return await blogRepository.getAllBlogsById(userId: params.userId);
  }
}

class GetAllBlogsByIdParams {
  final String userId;

  GetAllBlogsByIdParams({required this.userId});
}
