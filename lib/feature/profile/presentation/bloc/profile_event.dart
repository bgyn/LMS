import 'package:lms/core/params/update_profile_params.dart';

sealed class ProfileEvent {}

class ProfileGet extends ProfileEvent {}

class ProfileUpdate extends ProfileEvent {
  final UpdateProfileParams params;

  ProfileUpdate(this.params);
}
