import 'dart:convert';

class AuthResponseModel {
  final String accessToken;
  AuthResponseModel({
    required this.accessToken,
  });

  

  AuthResponseModel copyWith({
    String? accessToken,
  }) {
    return AuthResponseModel(
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      accessToken: map['accessToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) => AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthResponseModel(accessToken: $accessToken)';

  @override
  bool operator ==(covariant AuthResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.accessToken == accessToken;
  }

  @override
  int get hashCode => accessToken.hashCode;
}
