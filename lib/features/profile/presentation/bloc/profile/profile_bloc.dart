import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/profile/domain/usecases/get_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserInfo _getUserInfo;

  ProfileBloc({required final GetUserInfo getUserInfo})
      : _getUserInfo = getUserInfo,
        super(ProfileInitial()) {
    on<ProfileEvent>((_, emit) => emit(ProfileLoading()));
    on<FetchUserInformation>(_fetchUserInfo);
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
}
