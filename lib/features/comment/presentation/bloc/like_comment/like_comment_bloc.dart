import 'dart:developer';

import 'package:blog_app/features/comment/domain/usecases/is_comment_liked_by_user.dart';
import 'package:equatable/equatable.dart';
import 'package:blog_app/features/comment/domain/usecases/get_comment_blog_likes.dart';
import 'package:blog_app/features/comment/domain/usecases/like_comment.dart';
import 'package:blog_app/features/comment/domain/usecases/unlike_comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'like_comment_event.dart';
part 'like_comment_state.dart';

class LikeCommentBloc extends Bloc<LikeCommentEvent, LikeCommentState> {
  final LikeComment _likeComment;
  final UnLikeComment _unLikeComment;
  final GetCommentBlogLikes _getCommentBlogLikes;
  final IsCommentBlogLikedByUser _isCommentBlogLikedByUser;

  LikeCommentBloc({
    required LikeComment likeComment,
    required UnLikeComment unLikeComment,
    required GetCommentBlogLikes getCommentBlogLikes,
    required IsCommentBlogLikedByUser isCommentBlogLikedByUser,
  })  : _likeComment = likeComment,
        _unLikeComment = unLikeComment,
        _getCommentBlogLikes = getCommentBlogLikes,
        _isCommentBlogLikedByUser = isCommentBlogLikedByUser,
        super(const LikeCommentLoaded(likeStatuses: {})) {
    on<LoadLikeCommentStatus>(_onLoadLikeStatus);
    on<LikeCommentPressed>(_onLikeComment);
    on<UnLikeCommentPressed>(_onUnLikeComment);
  }

  Future<void> _onLoadLikeStatus(
    LoadLikeCommentStatus event,
    Emitter<LikeCommentState> emit,
  ) async {
    final currentState = state;
    if (currentState is! LikeCommentLoaded) return;

    final likeStatusResult = await _isCommentBlogLikedByUser(
      IsCommentBlogLikedByUserParams(
        commentId: event.commentId,
        userId: event.userId,
      ),
    );

    final countResult = await _getCommentBlogLikes(
      GetCommentBlogLikesParams(commentId: event.commentId),
    );

    bool isLiked = false;
    int likesCount = 0;

    likeStatusResult.fold(
      (failure) {
        log('Error checking if liked: ${failure.message}');
        // isLiked залишається false
      },
      (liked) {
        isLiked = liked;
      },
    );

    countResult.fold(
      (failure) {
        log('Error getting likes count: ${failure.message}');
        // likesCount залишається 0
      },
      (count) {
        likesCount = count;
      },
    );

    final updatedMap = Map<String, LikeStatus>.from(currentState.likeStatuses)
      ..[event.commentId] = LikeStatus(
        isLikedByUser: isLiked,
        likesCount: likesCount,
      );

    emit(LikeCommentLoaded(likeStatuses: updatedMap));
  }

  Future<void> _onLikeComment(
    LikeCommentPressed event,
    Emitter<LikeCommentState> emit,
  ) async {
    final result = await _likeComment(
      LikeCommentParams(
        commentId: event.commentId,
        userId: event.userId,
      ),
    );

    result.fold(
      (failure) {
        log('Error liking comment: ${failure.message}');
      },
      (_) {
        add(LoadLikeCommentStatus(
          commentId: event.commentId,
          userId: event.userId,
        ));
      },
    );
  }

  Future<void> _onUnLikeComment(
    UnLikeCommentPressed event,
    Emitter<LikeCommentState> emit,
  ) async {
    final result = await _unLikeComment(
      UnLikeCommentParams(
        commentId: event.commentId,
        userId: event.userId,
      ),
    );

    result.fold(
      (failure) {
        log('Error unliking comment: ${failure.message}');
      },
      (_) {
        add(LoadLikeCommentStatus(
          commentId: event.commentId,
          userId: event.userId,
        ));
      },
    );
  }
}
