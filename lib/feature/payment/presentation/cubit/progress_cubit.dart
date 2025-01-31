import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCubit extends Cubit<int> {
  ProgressCubit() : super(1);

  void increment() {
    if (state == 3) {
      return;
    }
    emit(state + 1);
  }

  void decrement() {
    if (state == 1) {
      return;
    }
    emit(state - 1);
  }
}
