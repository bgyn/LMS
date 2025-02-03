import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/params/update_profile_params.dart';
import 'package:lms/core/utils/show_snackbar.dart';
import 'package:lms/feature/profile/domain/usecase/get_profile.dart';
import 'package:lms/feature/profile/domain/usecase/upadate_profile.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_event.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile _getProfile;
  final UpadateProfile _upadateProfile;
  ProfileBloc(this._getProfile, this._upadateProfile)
      : super(ProfileInitial()) {
    on<ProfileGet>(_onGetProfile);
    on<ProfileUpdate>(_onUpdateProfile);
  }

  void _onGetProfile(ProfileGet event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _getProfile.call(null);
    result.fold((failure) {
      showSnackbar(failure.errorMessage);
      emit(ProfileError(failure.errorMessage));
    }, (profile) {
      emit(ProfileLoaded(profile));
    });
  }

  void _onUpdateProfile(ProfileUpdate event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _upadateProfile.call(UpdateProfileParams(
        name: event.params.name,
        bio: event.params.bio,
        profileImage: event.params.profileImage));
    result.fold((failure) {
      showSnackbar(failure.errorMessage);
      emit(ProfileError(failure.errorMessage));
    }, (profile) {
      showSnackbar('Profile updated successfully');
      emit(ProfileLoaded(profile));
    });
  }
}
