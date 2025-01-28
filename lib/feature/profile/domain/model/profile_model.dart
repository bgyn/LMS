class ProfileModel {
  final String id;
  final String? name;
  final String email;
  final String? profileImage;
  final String? bio;
  final String? role;
  ProfileModel({
    required this.id,
    this.name,
    required this.email,
    this.profileImage,
    this.bio,
    this.role,
  });

  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? bio,
    String? role,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'bio': bio,
      "role": role,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['_id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }
  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.bio == bio &&
        other.role == role &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profileImage.hashCode ^
        role.hashCode ^
        bio.hashCode;
  }
}
