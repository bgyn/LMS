class ProfileModel {
  final String id;
  final String? name;
  final String email;
  final String? profileImage;
  ProfileModel({
    required this.id,
    this.name,
    required this.email,
    this.profileImage,
  });

  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profile_image': profileImage,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      profileImage:
          map['profile_image'] != null ? map['profile_image'] as String : null,
    );
  }
  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ profileImage.hashCode;
  }
}
