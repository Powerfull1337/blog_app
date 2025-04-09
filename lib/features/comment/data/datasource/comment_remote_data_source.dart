import 'dart:developer';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/comment/data/models/comment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class CommentRemoteDataSource {
  Future<CommentModel> uploadComment(CommentModel comment);
  Future<List<CommentModel>> getAllCommentsByBlog(String blogId);
  Future<void> likeComment(String commentId, String userId);
  Future<void> unlikeComment(String commentId, String userId);
  Future<bool> isCommentLikedByUser(String commentId, String userId);
  Future<int> getCommentLikesCount(String commentId);
}

const _uuid = Uuid();

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
  Future<void> likeComment(String commentId, String userId) async {
    try {
      await supabaseClient.from('blog_comments_likes').insert({
        'id': _uuid.v1(),
        'comment_id': commentId,
        'user_id': userId,
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> unlikeComment(String commentId, String userId) async {
    try {
      await supabaseClient
          .from('blog_comments_likes')
          .delete()
          .match({'comment_id': commentId, 'user_id': userId});
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isCommentLikedByUser(String commentId, String userId) async {
    try {
      final result = await supabaseClient
          .from('blog_comments_likes')
          .select('id')
          .match({'comment_id': commentId, 'user_id': userId}).maybeSingle();

      return result != null;
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getCommentLikesCount(String commentId) async {
    try {
      final response = await supabaseClient
          .from('blog_comments_likes')
          .select('id')
          .eq('comment_id', commentId);

      return response.length;
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
}
