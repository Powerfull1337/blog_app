
import 'package:blog_app/domain/usecases/user_login.dart';
import 'package:blog_app/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_signUp);
    on<AuthLogin>(_login);
  }

  void _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
        email: event.email, name: event.name, password: event.password));
    res.fold((l) {
      emit(AuthFailure(l.message));
    }, (user) {
      emit(AuthSuccess(user));
    });
  }

  void _login(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((l) {
      emit(AuthFailure(l.message));
    }, (user) {
      emit(AuthSuccess(user));
    });
  }
}
