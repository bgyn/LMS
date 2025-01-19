import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/faliure/faliure.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/feature/auth/domain/usecase/is_user_logged_in.dart';
import 'package:lms/feature/auth/domain/usecase/signin.dart';
import 'package:lms/feature/auth/domain/usecase/signup.dart';
import 'package:lms/feature/auth/domain/usecase/singout.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsUserLoggedIn _isUserLoggedIn;
  final Singin _singin;
  final Singout _singout;
  final Signup _signup;

  AuthBloc(
      {required IsUserLoggedIn isUserLoggedIn,
      required Singin singin,
      required Singout singout,
      required Signup signup})
      : _isUserLoggedIn = isUserLoggedIn,
        _singin = singin,
        _signup = signup,
        _singout = singout,
        super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignIn>(_onAuthSignedIn);
    on<AuthSignUp>(_onAuthSignedUp);
    on<AuthSignOut>(_onAuthSignedOut);
  }

  void _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _isUserLoggedIn.call(null);
    result.fold(
      (failure) {
        if (failure is UnAuthorizedFailure) {
          emit(Unauthenticated(failure.errorMessage));
        } else {
          showSnackbar(failure.errorMessage);
          emit(Unauthenticated(failure.errorMessage));
        }
      },
      (user) => emit(Authenticated(user)),
    );
  }

  void _onAuthSignedIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit((AuthLogginIn()));
    final result = await _singin.call(event.params);
    result.fold(
      (failure) {
        showSnackbar(failure.errorMessage);
        emit(Unauthenticated(failure.errorMessage));
      },
      (user) => emit(Authenticated(user)),
    );
  }

  void _onAuthSignedUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLogginIn());
    final result = await _signup.call(event.params);
    result.fold(
      (failure) {
        showSnackbar(failure.errorMessage);
        emit(Unauthenticated(failure.errorMessage));
      },
      (user) => emit(Authenticated(user)),
    );
  }

  void _onAuthSignedOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _singout.call(null);
    result.fold(
      (failure) {
        showSnackbar(failure.errorMessage);
        emit(Unauthenticated(failure.errorMessage));
      },
      (_) => emit(AuthSignedOut()),
    );
  }
}
