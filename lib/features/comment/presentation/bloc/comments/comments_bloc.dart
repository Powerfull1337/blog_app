
import 'package:blog_app/features/comment/domain/entities/comment.dart';
import 'package:blog_app/features/comment/domain/usecases/get_all_comments_by_blog.dart';
import 'package:blog_app/features/comment/domain/usecases/upload_comment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetAllCommentByBlog _getAllCommentByBlog;
  final UploadComment _uploadComment;

  CommentsBloc({
    required GetAllCommentByBlog getAllCommentByBlog,
    required UploadComment uploadComment,
  })  : _getAllCommentByBlog = getAllCommentByBlog,
        _uploadComment = uploadComment,
        super(CommentsInitial()) {
    on<FetchCommentsEvent>(_onFetchComments);
    on<UploadCommentEvent>(_onUploadComment);
  }

  Future<void> _onFetchComments(
      FetchCommentsEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    final result = await _getAllCommentByBlog(
      GetAllCommentByBlogParams(blogId: event.blogId),
    );
    result.fold(
      (failure) => emit(CommentsError(message: failure.message)),
      (comments) => emit(CommentsLoaded(comments: comments)),
    );
  }

  Future<void> _onUploadComment(
      UploadCommentEvent event, Emitter<CommentsState> emit) async {
    final result = await _uploadComment(UploadCommentParams(
      blogId: event.blogId,
      userId: event.userId,
      content: event.content,
    ));

    result.fold(
      (failure) {
        emit(CommentsError(message: failure.message));
      },
      (_) {
        add(FetchCommentsEvent(blogId: event.blogId));
      },
    );
  }
}
