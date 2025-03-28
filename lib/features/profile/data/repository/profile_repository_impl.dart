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
    required File image,
    required String name,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(MessageConstants.noInternetConnection));
      }

      final currentUser = await profileRemoteDataSource.fetchUserInformation();

      UserModel userModel = currentUser.copyWith(name: name);

      final imageUrl = await profileRemoteDataSource.uploadProfileImage(
        user: userModel,
        image: image,
      );

      userModel = userModel.copyWith(imageUrl: imageUrl);

      await profileRemoteDataSource.updateUserInformation(user: userModel);

      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
