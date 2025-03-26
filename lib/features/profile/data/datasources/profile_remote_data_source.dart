import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> fetchUserInformation();
  Future<void> updateUserInformation({required UserModel user});
  Future<String> uploadProfileImage({required File image, required UserModel user});
}
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> fetchUserInformation() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) throw Exception("User is not logged in");

      final userInfo = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (userInfo != null) {
        final user = await supabaseClient.auth.getUser();
        final email = user.user?.email;
        final createdAt = user.user?.createdAt;

        return UserModel.fromJson({
          ...userInfo,
          'email': email,
          'created_at': createdAt,
        });
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> uploadProfileImage({required File image, required UserModel user}) async {
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
         'image_url': user.imageUrl,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await supabaseClient
          .from('profiles')
          .update(updates)
          .eq('id', userId);

      if (response == null) {
        throw Exception("Failed to update user information");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
