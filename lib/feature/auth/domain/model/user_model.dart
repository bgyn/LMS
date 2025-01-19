class UserModel {
  final String id;
  final String email;
  final String name;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'],
      email: map['email'],
      name: map['name'],
    );
  }

  //create a method to convert a UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      '\$id': id,
      'email': email,
      'name': name,
    };
  }
}
