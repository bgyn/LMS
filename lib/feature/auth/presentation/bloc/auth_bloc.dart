import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/feature/auth/domain/model/user_model.dart';
import 'package:lms/feature/auth/domain/usecase/get_current_user.dart';
import 'package:lms/feature/auth/domain/usecase/signin.dart';
import 'package:lms/feature/auth/domain/usecase/signup.dart';
import 'package:lms/feature/auth/domain/usecase/singout.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_event.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Singin _singin;
  final Singout _singout;
  final Signup _signup;
  final Getcurrentuser _getcurrentuser;
  final supabase.Supabase _supabase = supabase.Supabase.instance;
  StreamSubscription<supabase.User?>? _userSubscription;

  AuthBloc(
      {required Getcurrentuser getcurrentuser,
      required Singin singin,
      required Singout singout,
      required Signup signup})
      : _singin = singin,
        _getcurrentuser = getcurrentuser,
        _signup = signup,
        _singout = singout,
        super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignIn>(_onAuthSignedIn);
    on<AuthSignUp>(_onAuthSignedUp);
    on<AuthSignOut>(_onAuthSignedOut);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  void _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    _userSubscription = _getcurrentuser.getCurrentUser.listen((user) {
      if (user != null) {
        emit(Authenticated(UserModel(
          id: user.id,
          email: user.email!,
          name: user.userMetadata!["name"],
        )));
      } else {
        emit(Unauthenticated("User is not logged in"));
      }
    });
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
