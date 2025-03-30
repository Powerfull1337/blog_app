import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/profile/domain/usecases/get_user_info.dart';
import 'package:blog_app/features/profile/domain/usecases/update_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserInfo _getUserInfo;
  final UpdateUserInfo _updateUserInfo;

  ProfileBloc(
      {required final GetUserInfo getUserInfo,
      required final UpdateUserInfo updateUserInfo})
      : _getUserInfo = getUserInfo,
        _updateUserInfo = updateUserInfo,
        super(ProfileInitial()) {
    on<ProfileEvent>((_, emit) => emit(ProfileLoading()));
    on<FetchUserInformation>(_fetchUserInfo);
    on<UpdateUserInformation>(_updateUserInfoHandler);
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

  void _updateUserInfoHandler(
    UpdateUserInformation event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final res = await _updateUserInfo(UpdateUserInfoParams(
      name: event.name,
      image: event.image,
    ));

    res.fold(
      (l) => emit(ProfileFailure(l.message)),
      (r) => emit(ProfileLoaded(r)),
    );
  }
}
