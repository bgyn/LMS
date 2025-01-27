import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/feature/auth/domain/usecase/signin.dart';
import 'package:lms/feature/auth/domain/usecase/signup.dart';
import 'package:lms/feature/auth/domain/usecase/singout.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Singin _singin;
  final Singout _singout;
  final Signup _signup;

  AuthBloc(
      {required Singin singin,
      required Singout singout,
      required Signup signup})
      : _singin = singin,
        _signup = signup,
        _singout = singout,
        super(AuthInitial()) {
    on<AuthSignIn>(_onAuthSignedIn);
    on<AuthSignUp>(_onAuthSignedUp);
    on<AuthSignOut>(_onAuthSignedOut);
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
