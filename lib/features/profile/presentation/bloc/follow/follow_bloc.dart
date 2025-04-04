import 'package:blog_app/features/profile/domain/usecases/is_folowing.dart';

import 'package:blog_app/features/profile/domain/usecases/follow_to_user.dart';
import 'package:blog_app/features/profile/domain/usecases/unfollow_to_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final IsFollowing _isFollowing;
  final FollowToUser _subscribeToUser;
  final UnFollowToUser _unSubscribeToUser;

  FollowBloc({
    required IsFollowing isFollowing,
    required FollowToUser subscribeToUser,
    required UnFollowToUser unSubscribeToUser,
  })  : _isFollowing = isFollowing,
        _subscribeToUser = subscribeToUser,
        _unSubscribeToUser = unSubscribeToUser,
        super(FollowInitial()) {
    on<CheckIfFollowing>(_onCheckIfFollowing);
    on<FollowUser>(_onFollowUser);
    on<UnfollowUser>(_onUnfollowUser);
  }

  Future<void> _onCheckIfFollowing(
    CheckIfFollowing event,
    Emitter<FollowState> emit,
  ) async {
    emit(FollowLoading());
    final result = await _isFollowing(IsFollowingParams(userId: event.userId));
    result.fold(
      (failure) => emit(FollowError(failure.message)),
      (isFollowing) => emit(FollowStatus(isFollowing: isFollowing)),
    );
  }

  Future<void> _onFollowUser(
    FollowUser event,
    Emitter<FollowState> emit,
  ) async {
    emit(FollowLoading());
    final result =
        await _subscribeToUser(FollowToUserParams(userId: event.userId));
    result.fold(
      (failure) => emit(FollowError(failure.message)),
      (_) => emit(FollowActionSuccess(message: 'Successfully followed')),
    );
  }

  Future<void> _onUnfollowUser(
    UnfollowUser event,
    Emitter<FollowState> emit,
  ) async {
    emit(FollowLoading());
    final result =
        await _unSubscribeToUser(UnFollowToUserParams(userId: event.userId));
    result.fold(
      (failure) => emit(FollowError(failure.message)),
      (_) => emit(FollowActionSuccess(message: 'Successfully unfollowed')),
    );
  }
}
