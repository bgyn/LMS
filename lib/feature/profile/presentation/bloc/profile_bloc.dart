import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/feature/profile/domain/usecase/get_profile.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_event.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile _getProfile;
  ProfileBloc(this._getProfile) : super(ProfileInitial()) {
    on<ProfileGet>(_onGetProfile);
  }

  void _onGetProfile(ProfileGet event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _getProfile.call(null);
    result.fold((failure) => emit(ProfileError(failure.errorMessage)),
        (profile) => emit(ProfileLoaded(profile)));
  }
}
