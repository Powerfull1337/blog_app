import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:blog_app/features/blog/domain/usecases/get_blog_likes.dart';
import 'package:blog_app/features/blog/domain/usecases/is_blog_liked.dart';
import 'package:blog_app/features/blog/domain/usecases/like_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/unlike_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'like_blog_event.dart';
part 'like_blog_state.dart';

class LikeBlogBloc extends Bloc<LikeEvent, LikeState> {
  final LikeBlog likeBlogUseCase;
  final UnlikeBlog unlikeBlogUseCase;
  final IsBlogLiked isBlogLikedUseCase;
  final GetBlogLikes getBlogLikesUseCase;

  LikeBlogBloc({
    required this.likeBlogUseCase,
    required this.unlikeBlogUseCase,
    required this.isBlogLikedUseCase,
    required this.getBlogLikesUseCase,
  }) : super(const LikeState()) {
    on<LikeBlogEvent>(_onLikeBlog);
    on<UnlikeBlogEvent>(_onUnlikeBlog);
    on<CheckIfBlogLikedEvent>(_onCheckIfLiked);
    on<GetLikesCountEvent>(_onGetLikesCount);
    on<InitializeLikeStateEvent>(_onInitializeLikeState);
    on<ResetLikeStateEvent>((event, emit) {
      emit(const LikeState());
    });
  }

  Future<void> _onLikeBlog(LikeBlogEvent event, Emitter<LikeState> emit) async {
    final result = await likeBlogUseCase(
      LikeBlogParams(blogId: event.blogId, userId: event.userId),
    );

    result.fold(
      (failure) {
        // handle error if needed
      },
      (_) {
        emit(
          state.copyWith(
            isLiked: true,
            likesCount: state.likesCount + 1,
          ),
        );
      },
    );
  }

  Future<void> _onUnlikeBlog(
      UnlikeBlogEvent event, Emitter<LikeState> emit) async {
    final result = await unlikeBlogUseCase(
      UnlikeBlogParams(blogId: event.blogId, userId: event.userId),
    );

    result.fold(
      (failure) {
        log(failure.toString());
      },
      (_) {
        emit(
          state.copyWith(
            isLiked: false,
            likesCount: (state.likesCount > 0) ? state.likesCount - 1 : 0,
          ),
        );
      },
    );
  }

  Future<void> _onCheckIfLiked(
      CheckIfBlogLikedEvent event, Emitter<LikeState> emit) async {
    final result = await isBlogLikedUseCase(
      IsBlogLikedParams(blogId: event.blogId, userId: event.userId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLiked: false)); // <- emit навіть при помилці
      },
      (isLiked) {
        emit(state.copyWith(isLiked: isLiked));
      },
    );
  }

  Future<void> _onGetLikesCount(
      GetLikesCountEvent event, Emitter<LikeState> emit) async {
    final result = await getBlogLikesUseCase(
      GetBlogLikesParams(blogId: event.blogId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(likesCount: 0)); // <- emit навіть при помилці
      },
      (count) {
        emit(state.copyWith(likesCount: count));
      },
    );
  }

  void _onInitializeLikeState(
      InitializeLikeStateEvent event, Emitter<LikeState> emit) {
    emit(state.copyWith(
      isLiked: event.isLiked,
      likesCount: event.likesCount,
    ));
  }
}
