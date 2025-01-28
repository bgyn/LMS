import 'package:get_it/get_it.dart';
import 'package:lms/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:lms/feature/auth/data/source/localsource/auth_local_service.dart';
import 'package:lms/feature/auth/data/source/remote/auth_api_service.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';
import 'package:lms/feature/auth/domain/usecase/is_user_logged_in.dart';
import 'package:lms/feature/auth/domain/usecase/signin.dart';
import 'package:lms/feature/auth/domain/usecase/signup.dart';
import 'package:lms/feature/auth/domain/usecase/singout.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/password_reset/data/repository/password_reset_repository_impl.dart';
import 'package:lms/feature/password_reset/data/source/remote/password_reset_api_service.dart';
import 'package:lms/feature/password_reset/domain/repository/password_reset_repository.dart';
import 'package:lms/feature/password_reset/domain/usecase/reset_password.dart';
import 'package:lms/feature/password_reset/domain/usecase/send_password_reset.dart';
import 'package:lms/feature/password_reset/domain/usecase/verify_otp.dart';
import 'package:lms/feature/profile/data/datasource/remote/supabase_profile_service.dart';
import 'package:lms/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:lms/feature/profile/domain/repository/profile_repository.dart';
import 'package:lms/feature/profile/domain/usecase/get_profile.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //auth
  sl.registerSingleton<AuthApiService>(AuthApiService());
  sl.registerSingleton<LocalAuthApiService>(LocalAuthApiService());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));
  sl.registerSingleton<Singin>(Singin(sl()));
  sl.registerSingleton<Signup>(Signup(sl()));
  sl.registerSingleton<Singout>(Singout(sl()));
  sl.registerSingleton<IsUserLoggedIn>(IsUserLoggedIn(sl()));
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
        singin: sl(),
        singout: sl(),
        signup: sl(),
        isUserLoggedIn: sl(),
      ));

  //password reset
  sl.registerSingleton<PasswordResetApiService>(PasswordResetApiService());
  sl.registerSingleton<PasswordResetRepository>(
      PasswordResetRepositoryImpl(sl()));
  sl.registerSingleton<ResetPassword>(ResetPassword(sl()));
  sl.registerSingleton<SendPasswordReset>(SendPasswordReset(sl()));
  sl.registerSingleton<VerifyOtp>(VerifyOtp(sl()));

  //profile
  sl.registerSingleton<SupabaseProfileService>(SupabaseProfileService());
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<GetProfile>(() => GetProfile(sl()));
}
