import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:lms/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:lms/feature/auth/data/source/remote/appwrite_auth_service.dart';
import 'package:lms/feature/auth/domain/repository/auth_repository.dart';
import 'package:lms/feature/auth/domain/usecase/is_user_logged_in.dart';
import 'package:lms/feature/auth/domain/usecase/signin.dart';
import 'package:lms/feature/auth/domain/usecase/signup.dart';
import 'package:lms/feature/auth/domain/usecase/singout.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  Client client = Client();
  sl.registerSingleton<Client>(client
      .setEndpoint(dotenv.get("ENDPOINT"))
      .setProject(dotenv.get("PROJECT_ID"))
      .setSelfSigned(status: true));
  sl.registerSingleton<Account>(Account(sl()));

  //auth
  sl.registerSingleton<AppwriteAuthService>(AppwriteAuthService());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<IsUserLoggedIn>(IsUserLoggedIn(sl()));
  sl.registerSingleton<Singin>(Singin(sl()));
  sl.registerSingleton<Signup>(Signup(sl()));
  sl.registerSingleton<Singout>(Singout(sl()));
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
        isUserLoggedIn: sl(),
        singin: sl(),
        singout: sl(),
        signup: sl(),
      ));
}
