import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_logout.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_by_id.dart';
import 'package:blog_app/features/blog/domain/usecases/get_blog_likes.dart';
import 'package:blog_app/features/blog/domain/usecases/get_count_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/is_blog_liked.dart';
import 'package:blog_app/features/blog/domain/usecases/like_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/unlike_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/like_blog/like_blog_bloc.dart';
import 'package:blog_app/features/comment/data/datasource/comment_remote_data_source.dart';
import 'package:blog_app/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:blog_app/features/comment/domain/repositories/comment_repository.dart';
import 'package:blog_app/features/comment/domain/usecases/get_all_comments_by_blog.dart';
import 'package:blog_app/features/comment/domain/usecases/get_comment_blog_likes.dart';
import 'package:blog_app/features/comment/domain/usecases/is_comment_liked_by_user.dart';
import 'package:blog_app/features/comment/domain/usecases/like_comment.dart';
import 'package:blog_app/features/comment/domain/usecases/unlike_comment.dart';
import 'package:blog_app/features/comment/domain/usecases/upload_comment.dart';
import 'package:blog_app/features/comment/presentation/bloc/comments/comments_bloc.dart';
import 'package:blog_app/features/comment/presentation/bloc/like_comment/like_comment_bloc.dart';
import 'package:blog_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:blog_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:blog_app/features/profile/domain/usecases/follow_to_user.dart';
import 'package:blog_app/features/profile/domain/usecases/get_all_users.dart';
import 'package:blog_app/features/profile/domain/usecases/get_user_info.dart';
import 'package:blog_app/features/profile/domain/usecases/is_folowing.dart';
import 'package:blog_app/features/profile/domain/usecases/unfollow_to_user.dart';
import 'package:blog_app/features/profile/domain/usecases/update_user_info.dart';
import 'package:blog_app/features/profile/presentation/bloc/follow/follow_bloc.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");

  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerSingletonAsync<Database>(
    () async => await initDB(),
  );

  await serviceLocator.isReady<Database>();

  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );

  _initAuth();
  _initBlog();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImplementation(serviceLocator()))
    ..registerFactory(() => ConnectionCheckerImpl(serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImplementation(serviceLocator(), serviceLocator()))
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userLogout: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // -------Datasource--------------------
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        serviceLocator<Database>(),
      ),
    )
    ..registerFactory<CommentRemoteDataSource>(
      () => CommentRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // --------------Repository-------------------
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<CommentRepository>(
      () => CommentRepositoryImpl(
        serviceLocator(),
      ),
    )

    //----------- Usecases-------------------

    // User
    ..registerFactory(
      () => GetUserInfo(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateUserInfo(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllUsers(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogout(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    // ..registerFactory(
    //   () => GetAllBlogs(
    //     serviceLocator(),
    //   ),
    // )
    ..registerFactory(
      () => GetAllBlogsById(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetCountBlog(
        serviceLocator(),
      ),
    )

    // Likes
    ..registerFactory(
      () => LikeBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UnlikeBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetBlogLikes(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => IsBlogLiked(
        serviceLocator(),
      ),
    )

    //Follow
    ..registerFactory(
      () => FollowToUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UnFollowToUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => IsFollowing(
        serviceLocator(),
      ),
    )

    // Comment
    ..registerFactory(
      () => GetAllCommentByBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadComment(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => LikeComment(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UnLikeComment(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetCommentBlogLikes(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => IsCommentBlogLikedByUser(
        serviceLocator(),
      ),
    )



    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        //    getAllBlogs: serviceLocator(),
        getAllBlogsById: serviceLocator(),
        //   getCountBlog: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ProfileBloc(
        getUserInfo: serviceLocator(),
        updateUserInfo: serviceLocator(),
        getAllUsers: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FollowBloc(
        isFollowing: serviceLocator(),
        subscribeToUser: serviceLocator(),
        unSubscribeToUser: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => LikeBlogBloc(
          likeBlogUseCase: serviceLocator(),
          unlikeBlogUseCase: serviceLocator(),
          isBlogLikedUseCase: serviceLocator(),
          getBlogLikesUseCase: serviceLocator(),
        ))
    ..registerLazySingleton(() => CommentBloc(
          getAllCommentByBlog: serviceLocator(),
          uploadComment: serviceLocator(),
        ))
    ..registerLazySingleton(() => LikeCommentBloc(
          likeComment: serviceLocator(),
          unLikeComment: serviceLocator(),
          getCommentBlogLikes: serviceLocator(),
          isCommentBlogLikedByUser: serviceLocator(),
        ));
}
