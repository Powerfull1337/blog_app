import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> fetchUserInformation();
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
        final email = supabaseClient.auth.currentUser?.email;

        return UserModel.fromJson({
          ...userInfo,
          'email': email,
        });
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
