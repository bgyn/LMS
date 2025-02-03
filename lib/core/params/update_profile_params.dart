import 'dart:io';

class UpdateProfileParams {
  final File? profileImage;
  final String? name;
  final String? bio;

  UpdateProfileParams({
    this.profileImage,
    this.name,
    this.bio,
  });
}
