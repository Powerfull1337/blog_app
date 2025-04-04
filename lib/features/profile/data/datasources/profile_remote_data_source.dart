import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> fetchUserInformation();
  Future<List<UserModel>> fetchAllUsers();
  Future<void> updateUserInformation({required UserModel user});
  Future<String> uploadProfileImage(
      {required File image, required UserModel user});
  Future<void> followUser({required String userId});
  Future<void> unfollowUser({required String userId});
  Future<bool> isFollowing({required String userId});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  String? get currentUserId => supabaseClient.auth.currentUser?.id;

  @override
  Future<void> followUser({required String userId}) async {
    try {
      if (currentUserId == null) throw Exception("User is not logged in");

      await supabaseClient.from('followers').insert({
        'follower_id': currentUserId,
        'following_id': userId,
      });

      log("Successfully followed user: $userId");
    } catch (e) {
      log("Error following user: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> unfollowUser({required String userId}) async {
    try {
      if (currentUserId == null) throw Exception("User is not logged in");

      await supabaseClient
          .from('followers')
          .delete()
          .match({'follower_id': currentUserId!, 'following_id': userId});

      log("Successfully unfollowed user: $userId");
    } catch (e) {
      log("Error unfollowing user: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isFollowing({required String userId}) async {
    try {
      if (currentUserId == null) throw Exception("User is not logged in");

      final result = await supabaseClient
          .from('followers')
          .select('id')
          .match({'follower_id': currentUserId!, 'following_id': userId})
          .maybeSingle();

      return result != null;
    } catch (e) {
      log("Error checking follow status: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> fetchUserInformation() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception("User is not logged in");

      final userInfo = await supabaseClient
          .from('profiles')
          .select('id, name, avatar_url, bio')
          .eq('id', userId)
          .maybeSingle();

      if (userInfo != null) {
        final user = await supabaseClient.auth.getUser();
        final email = user.user?.email;
        final createdAt = user.user?.createdAt;

        return UserModel.fromJson({
          ...userInfo,
          'email': email,
          'updated_at': createdAt,
        });
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> uploadProfileImage(
      {required File image, required UserModel user}) async {
    try {
      await supabaseClient.storage.from('avatars').update(user.id, image);
      return supabaseClient.storage.from('avatars').getPublicUrl(user.id);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateUserInformation({required UserModel user}) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception("User is not logged in");

      final updates = {
        'name': user.name,
        'avatar_url': user.avatarUrl,
        'bio': user.bio,
      };

      final response = await supabaseClient
          .from('profiles')
          .update(updates)
          .eq('id', userId)
          .select();

      if (response.isEmpty) {
        log(response.toString());
        throw Exception("Failed to update user information");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final currentUserId = supabaseClient.auth.currentUser?.id;
      if (currentUserId == null) throw Exception("User is not logged in");

      final usersData = await supabaseClient
          .from('profiles')
          .select('id, name, avatar_url, bio')
          .neq('id', currentUserId); 

      return usersData
          .map<UserModel>((user) => UserModel.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
