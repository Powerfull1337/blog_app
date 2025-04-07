
part of 'comments_bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class FetchCommentsEvent extends CommentsEvent {
  final String blogId;

  const FetchCommentsEvent({required this.blogId});

  @override
  List<Object> get props => [blogId];
}

class UploadCommentEvent extends CommentsEvent {
  final String blogId;
  final String userId;
  final String content;

  const UploadCommentEvent({
    required this.blogId,
    required this.userId,
    required this.content,
  });

  @override
  List<Object> get props => [blogId, userId, content];
}
