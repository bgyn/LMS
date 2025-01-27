import 'package:get_it/get_it.dart';
import 'package:lms/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:lms/feature/auth/data/source/remote/auth_api_service.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';
import 'package:lms/feature/auth/domain/usecase/signin.dart';
import 'package:lms/feature/auth/domain/usecase/signup.dart';
import 'package:lms/feature/auth/domain/usecase/singout.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/profile/data/datasource/remote/supabase_profile_service.dart';
import 'package:lms/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:lms/feature/profile/domain/repository/profile_repository.dart';
import 'package:lms/feature/profile/domain/usecase/get_profile.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //auth
  sl.registerSingleton<AuthApiService>(AuthApiService());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<Singin>(Singin(sl()));
  sl.registerSingleton<Signup>(Signup(sl()));
  sl.registerSingleton<Singout>(Singout(sl()));
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
        singin: sl(),
        singout: sl(),
        signup: sl(),
      ));

  //profile
  sl.registerSingleton<SupabaseProfileService>(SupabaseProfileService());
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<GetProfile>(() => GetProfile(sl()));
}
