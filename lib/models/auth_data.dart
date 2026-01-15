import 'dart:convert';

class AuthData {
  final int userId;
  final String firstName;
  final String lastName;
  final String accessToken;
  final String refreshToken;
  final String email;
  final String? expiryDate;

  AuthData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.accessToken,
    required this.refreshToken,
    required this.email,
    this.expiryDate,
  });

  AuthData copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? accessToken,
    String? refreshToken,
    String? email,
    String? expiryDate,
  }) {
    return AuthData(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      email: email ?? this.email,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'email': email,
      'expiryDate': expiryDate,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      userId: map['userId'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      email: map['email'] as String,
      expiryDate: map['expiryDate'] != null
          ? map['expiryDate'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) =>
      AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthData(userId: $userId, firstName: $firstName, lastName: $lastName, accessToken: $accessToken, refreshToken: $refreshToken, email: $email, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.email == email &&
        other.expiryDate == expiryDate;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        email.hashCode ^
        expiryDate.hashCode;
  }
}
