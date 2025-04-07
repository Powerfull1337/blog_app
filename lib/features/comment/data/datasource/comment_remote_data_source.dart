import 'dart:developer';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/comment/data/models/comment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CommentRemoteDataSource {
  Future<CommentModel> uploadComment(CommentModel comment);
  Future<List<CommentModel>> getAllCommentsByBlog(String blogId);
  Future<void> likeComment(String commentId, String userId);
  Future<void> unlikeComment(String commentId, String userId);
  Future<bool> isCommentLikedByUser(String commentId, String userId);
  Future<int> getCommentLikesCount(String commentId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final SupabaseClient supabaseClient;

  CommentRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<CommentModel> uploadComment(CommentModel comment) async {
    try {
      final commentData = await supabaseClient
          .from('blog_comments')
          .insert(comment.toJson())
          .select();

      return CommentModel.fromJson(commentData.first);
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CommentModel>> getAllCommentsByBlog(String blogId) async {
    try {
      final commentData = await supabaseClient
          .from('blog_comments')
          .select('*, profiles(name, avatar_url)')
          .eq('blog_id', blogId)
          .order('created_at', ascending: true);

      return commentData
          .map<CommentModel>((json) => CommentModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getCommentLikesCount(String commentId) {
    // TODO: implement getCommentLikesCount
    throw UnimplementedError();
  }

  @override
  Future<bool> isCommentLikedByUser(String commentId, String userId) {
    // TODO: implement isCommentLikedByUser
    throw UnimplementedError();
  }

  @override
  Future<void> likeComment(String commentId, String userId) {
    // TODO: implement likeComment
    throw UnimplementedError();
  }

  @override
  Future<void> unlikeComment(String commentId, String userId) {
    // TODO: implement unlikeComment
    throw UnimplementedError();
  }
}
