import 'dart:io';

import 'package:blog_app/core/constants/message_constants.dart';
import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ConnectionChecker connectionChecker;

  ProfileRepositoryImpl(this.profileRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> getUserInformation() async {
    try {
      final user = await profileRemoteDataSource.fetchUserInformation();
      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserInformation({
    File? image,
    String? name,
    String? bio,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(MessageConstants.noInternetConnection));
      }

      final currentUser = await profileRemoteDataSource.fetchUserInformation();
      UserModel userModel = currentUser;

      String? avatarUrl;

      if (image != null) {
        avatarUrl = await profileRemoteDataSource.uploadProfileImage(
          user: userModel,
          image: image,
        );
        userModel = userModel.copyWith(avatarUrl: avatarUrl);
      }

      // if (name != null && name.isNotEmpty) {
      userModel = userModel.copyWith(name: name, bio: bio);
      // }

      await profileRemoteDataSource.updateUserInformation(user: userModel);

      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<User>>> getAllUsers()async{
      try {
      final users = await profileRemoteDataSource.fetchAllUsers();
      return right(users);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
