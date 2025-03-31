import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/profile/domain/usecases/get_all_users.dart';
import 'package:blog_app/features/profile/domain/usecases/get_user_info.dart';
import 'package:blog_app/features/profile/domain/usecases/update_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserInfo _getUserInfo;
  final UpdateUserInfo _updateUserInfo;
  final GetAllUsers _getAllUsers;

  ProfileBloc(
      {required final GetUserInfo getUserInfo,
      required final GetAllUsers getAllUsers,
      required final UpdateUserInfo updateUserInfo})
      : _getUserInfo = getUserInfo,
        _updateUserInfo = updateUserInfo,
        _getAllUsers = getAllUsers,
        super(ProfileInitial()) {
    on<ProfileEvent>((_, emit) => emit(ProfileLoading()));
    on<FetchUserInformation>(_fetchUserInfo);
    on<UpdateUserInformation>(_updateUserInfoHandler);
    on<FetchAllUsers>(_fetchAllUsers);
  }

  void _fetchUserInfo(
    FetchUserInformation event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _getUserInfo(NoParams());
    res.fold(
      (l) => emit(ProfileFailure(l.message)),
      (r) => emit(ProfileLoaded(r)),
    );
  }
   void _fetchAllUsers(
    FetchAllUsers event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _getAllUsers(NoParams());
    res.fold(
      (l) => emit(ProfileFailure(l.message)),
      (r) => emit(UsersLoaded(users: r)),
    );
  }

  void _updateUserInfoHandler(
    UpdateUserInformation event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final res = await _updateUserInfo(UpdateUserInfoParams(
      name: event.name,
      image: event.image,
      bio: event.bio,
    ));

    res.fold(
      (l) => emit(ProfileFailure(l.message)),
      (r) => emit(ProfileLoaded(r)),
    );
  }
}
