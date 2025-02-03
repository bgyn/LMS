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
import 'package:lms/feature/course/data/data/remote/course_api_service.dart';
import 'package:lms/feature/course/data/repository/course_repository_impl.dart';
import 'package:lms/feature/course/domain/repository/course_repository.dart';
import 'package:lms/feature/course/domain/usecase/get_course.dart';
import 'package:lms/feature/course_detail/data/repository/course_detail_repository_impl.dart';
import 'package:lms/feature/course_detail/data/source/remote/course_detail_api_service.dart';
import 'package:lms/feature/course_detail/domain/respository/course_detail_repository.dart';
import 'package:lms/feature/course_detail/domain/usecase/get_course_details_by_id.dart';
import 'package:lms/feature/password_reset/data/repository/password_reset_repository_impl.dart';
import 'package:lms/feature/password_reset/data/source/remote/password_reset_api_service.dart';
import 'package:lms/feature/password_reset/domain/repository/password_reset_repository.dart';
import 'package:lms/feature/password_reset/domain/usecase/reset_password.dart';
import 'package:lms/feature/password_reset/domain/usecase/send_password_reset.dart';
import 'package:lms/feature/password_reset/domain/usecase/verify_otp.dart';
import 'package:lms/feature/payment/data/repository/payment_repository_impl.dart';
import 'package:lms/feature/payment/data/source/remote/payment_api_service.dart';
import 'package:lms/feature/payment/domain/repository/payment_repository.dart';
import 'package:lms/feature/payment/domain/usecase/create_payment_intent.dart';
import 'package:lms/feature/profile/data/datasource/remote/profile_api_service.dart';
import 'package:lms/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:lms/feature/profile/domain/repository/profile_repository.dart';
import 'package:lms/feature/profile/domain/usecase/get_profile.dart';
import 'package:lms/feature/profile/domain/usecase/upadate_profile.dart';

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
  sl.registerSingleton<ProfileApiService>(ProfileApiService());
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(sl()));
  sl.registerSingleton<UpadateProfile>(UpadateProfile(sl()));
  sl.registerLazySingleton<GetProfile>(() => GetProfile(sl()));

  //course
  sl.registerSingleton<CourseApiService>(CourseApiService());
  sl.registerSingleton<CourseRepository>(CourseRepositoryImpl(sl()));
  sl.registerSingleton<GetCourse>(GetCourse(sl()));

  //course detail
  sl.registerSingleton<CourseDetailApiService>(CourseDetailApiService());
  sl.registerSingleton<CourseDetailRepository>(
      CourseDetailRepositoryImpl(sl()));
  sl.registerSingleton<GetCourseDetailsById>(GetCourseDetailsById(sl()));

  //payment
  sl.registerSingleton<PaymentApiService>(PaymentApiService());
  sl.registerSingleton<PaymentRepository>(PaymentRepositoryImpl(sl()));
  sl.registerSingleton<CreatePaymentIntent>(CreatePaymentIntent(sl()));
}
