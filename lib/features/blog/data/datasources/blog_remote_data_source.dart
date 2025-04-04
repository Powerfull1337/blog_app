import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<int> getCountBlog(String userId);
 // Future<List<BlogModel>> getAllBlogs();
  Future<List<BlogModel>> getAllBlogsById(String userId);

  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});

  Future<void> likeBlog(String blogId, String userId);
  Future<void> unlikeBlog(String blogId, String userId);
  Future<bool> isBlogLiked(String blogId, String userId);
  Future<int> getBlogLikesCount(String blogId);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').update(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<List<BlogModel>> getAllBlogs() async {
  //   try {
  //     final blogs =
  //         await supabaseClient.from('blogs').select('*, profiles (name)');

  //     return blogs
  //         .map(
  //           (blog) => BlogModel.fromJson(blog).copyWith(
  //             posterName: blog['profiles']['name'],
  //           ),
  //         )
  //         .toList();
  //   } on PostgrestException catch (e) {
  //     throw ServerException(e.message);
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

  @override
  Future<List<BlogModel>> getAllBlogsById(String userId) async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles (name)')
          .eq('poster_id', userId);

      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
            ),
          )
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
  Future<int> getCountBlog(String userId) async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('id')
          .eq('poster_id', userId);

      return blogs.length;
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> likeBlog(String blogId, String userId) async {
    try {
      await supabaseClient.from('blog_likes').insert({
        'blog_id': blogId,
        'user_id': userId,
      });
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> unlikeBlog(String blogId, String userId) async {
    try {
      await supabaseClient
          .from('blog_likes')
          .delete()
          .match({'blog_id': blogId, 'user_id': userId});
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    }
  }

  @override
  Future<bool> isBlogLiked(String blogId, String userId) async {
    try {
      final response = await supabaseClient
          .from('blog_likes')
          .select('id')
          .match({'blog_id': blogId, 'user_id': userId});

      return response.isNotEmpty;
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    }
  }

  @override
  Future<int> getBlogLikesCount(String blogId) async {
    try {
      final response = await supabaseClient
          .from('blog_likes')
          .select('id')
          .eq('blog_id', blogId);

      return response.length;
    } on PostgrestException catch (e) {
      log(e.toString());
      throw ServerException(e.message);
    }
  }
}
