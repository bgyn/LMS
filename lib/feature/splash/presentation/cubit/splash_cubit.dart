import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms/feature/auth/presentation/bloc/auth_state.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_bloc.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_event.dart';
import 'package:lms/feature/my_course/presentation/bloc/my_course_state.dart';

class SplashCubit extends Cubit<bool> {
  final AuthBloc authbloc;
  final MyCourseBloc myCourseBloc;
  Completer<void>? loadingCompleter = Completer<void>();

  SplashCubit({required this.authbloc, required this.myCourseBloc})
      : super(false) {
    _intialize();
  }

  Future<void> _intialize() async {
    authbloc.stream.listen((authState) {
      if (authState is Authenticated) {
        _loadInitialData();
      }
    });
    myCourseBloc.stream.listen((myCourseState) {
      if (myCourseState is MyCourseFailure) {
        emit(false);
        loadingCompleter?.complete();
      } else if (myCourseState is MyCourseSuccess) {
        emit(true);
        loadingCompleter?.complete();
      }
    });
    await loadingCompleter!.future;
  }

  void _loadInitialData() {
    if (!loadingCompleter!.isCompleted) {
      loadingCompleter = Completer<void>();
    }

    try {
      myCourseBloc.add(FetchMyCourse());
    } catch (e) {
      emit(false);
      _completeLoading();
    }
  }

  void _completeLoading() {
    if (!loadingCompleter!.isCompleted) {
      loadingCompleter!.complete();
    }
  }
}
