import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/features/blog/domain/usecases/like_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/unlike_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_blog_likes.dart';
import 'package:blog_app/features/blog/domain/usecases/is_blog_liked.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeBlog _likeBlog;
  final UnlikeBlog _unlikeBlog;
  final GetBlogLikes _getBlogLikes;
  final IsBlogLiked _isBlogLiked;

  LikeBloc({
    required LikeBlog likeBlog,
    required UnlikeBlog unlikeBlog,
    required GetBlogLikes getBlogLikes,
    required IsBlogLiked isBlogLiked,
  })  : _likeBlog = likeBlog,
        _unlikeBlog = unlikeBlog,
        _getBlogLikes = getBlogLikes,
        _isBlogLiked = isBlogLiked,
        super(LikeInitial()) {
    on<LikeBlogEvent>(_onLike);
    on<UnlikeBlogEvent>(_onUnlike);
    on<FetchLikeCountEvent>(_onFetchCount);
    on<FetchLikeInfo>(_onFetchLikeInfo);
  }

  Future<void> _onLike(LikeBlogEvent event, Emitter<LikeState> emit) async {
    final res = await _likeBlog(LikeBlogParams(
      blogId: event.blogId,
      userId: event.userId,
    ));
    res.fold(
      (l) => emit(LikeError(l.message)),
      (_) => add(FetchLikeInfo(blogId: event.blogId, userId: event.userId)),
    );
  }

  Future<void> _onUnlike(UnlikeBlogEvent event, Emitter<LikeState> emit) async {
    final res = await _unlikeBlog(UnlikeBlogParams(
      blogId: event.blogId,
      userId: event.userId,
    ));
    res.fold(
      (l) => emit(LikeError(l.message)),
      (_) => add(FetchLikeInfo(blogId: event.blogId, userId: event.userId)),
    );
  }

  Future<void> _onFetchCount(FetchLikeCountEvent event, Emitter<LikeState> emit) async {
    final res = await _getBlogLikes(GetBlogLikesParams(blogId: event.blogId));
    res.fold(
      (l) => emit(LikeError(l.message)),
      (count) => emit(LikeCountUpdated(count)),
    );
  }

  Future<void> _onFetchLikeInfo(FetchLikeInfo event, Emitter<LikeState> emit) async {
    emit(LikeLoading());

    final countRes = await _getBlogLikes(GetBlogLikesParams(blogId: event.blogId));
    final likedRes = await _isBlogLiked(IsBlogLikedParams(
      blogId: event.blogId,
      userId: event.userId,
    ));

    final count = await countRes.fold((l) {
      emit(LikeError(l.message));
      return null;
    }, (r) => r);

    final isLiked = await likedRes.fold((l) {
      emit(LikeError(l.message));
      return null;
    }, (r) => true);

    if (count != null && isLiked != null) {
      emit(LikeLoaded(count: count, isLiked: isLiked));
    }
  }
}
