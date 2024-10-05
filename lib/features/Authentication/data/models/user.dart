import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String? middleName;
  final int userType;
  final int accountStatus;
  final List<String> roles;
  final String token;
  final String privileges;
  final int expires;
  final bool isEmailVerified;
  final String signupKey;
  final String phoneNumber;

  UserModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.userType,
    required this.accountStatus,
    required this.roles,
    required this.token,
    required this.privileges,
    required this.expires,
    required this.isEmailVerified,
    required this.signupKey,
    required this.phoneNumber,
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'userType': userType,
      'accountStatus': accountStatus,
      'roles': roles,
      'token': token,
      'privileges': privileges,
      'expires': expires,
      'isEmailVerified': isEmailVerified,
      'signupKey': signupKey,
      'phoneNumber': phoneNumber,
    };
  }

  // Create UserModel from JSON
  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      userType: json['userType'],
      accountStatus: json['accountStatus'],
      roles: List<String>.from(json['roles']),
      token: json['token'],
      privileges: json['privileges'],
      expires: json['expires'],
      isEmailVerified: json['isEmailVerified'],
      signupKey: json['signupKey'] ?? '',
      phoneNumber: json['phoneNumber'],
    );
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        firstName,
        lastName,
        middleName,
        userType,
        accountStatus,
        roles,
        token,
        privileges,
        expires,
        isEmailVerified,
        signupKey,
        phoneNumber,
      ];
}
