import 'package:get_it/get_it.dart';
import 'package:lms/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:lms/feature/auth/data/source/remote/supabse_auth_service.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';
import 'package:lms/feature/auth/domain/usecase/get_current_user.dart';
import 'package:lms/feature/auth/domain/usecase/signin.dart';
import 'package:lms/feature/auth/domain/usecase/signup.dart';
import 'package:lms/feature/auth/domain/usecase/singout.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //auth
  sl.registerSingleton<SupabaseAuthService>(SupabaseAuthService());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<Singin>(Singin(sl()));
  sl.registerSingleton<Signup>(Signup(sl()));
  sl.registerSingleton<Singout>(Singout(sl()));
  sl.registerSingleton<Getcurrentuser>(Getcurrentuser(sl()));
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
        getcurrentuser: sl(),
        singin: sl(),
        singout: sl(),
        signup: sl(),
      ));
}
