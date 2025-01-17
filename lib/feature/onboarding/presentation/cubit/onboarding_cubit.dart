import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int>{
  OnboardingCubit():super(0);

  void next(){
    emit(state+1);
  }

  void back(){
    emit(state-1);
  }
  
}