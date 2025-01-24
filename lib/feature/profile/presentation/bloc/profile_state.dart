import 'package:lms/feature/profile/domain/model/profile_model.dart';

sealed class ProfileState {
  final ProfileModel? profile;
  final String? error;
  ProfileState({this.profile, this.error});
}

class ProfileInitial extends ProfileState {
  ProfileInitial() : super(profile: null, error: null);
}

class ProfileLoading extends ProfileState {
  ProfileLoading() : super(profile: null, error: null);
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(ProfileModel profile) : super(profile: profile, error: null);
}

class ProfileError extends ProfileState {
  ProfileError(String error) : super(profile: null, error: error);
}
