import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/data/repository/auth_repository_impl.dart';
import 'package:blog_app/domain/repository/auth_repository.dart';
import 'package:blog_app/domain/usecases/current_user.dart';
import 'package:blog_app/domain/usecases/user_login.dart';
import 'package:blog_app/domain/usecases/user_sign_up.dart';
import 'package:blog_app/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");

  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImplementation(serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImplementation(serviceLocator()))
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator()),
    );
}
