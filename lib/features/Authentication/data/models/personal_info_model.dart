import 'package:equatable/equatable.dart';

class PersonalInfoModel extends Equatable {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String dob;
  final int gender;
  final String phoneNumber;

  PersonalInfoModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.dob,
    required this.gender,
    required this.phoneNumber,
  });

  // Method to convert PersonalInfoModel to a Map (useful for JSON or API requests)
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'dob': dob,
      'gender': gender,
      'phoneNumber': phoneNumber,
    };
  }

  // Method to create PersonalInfoModel from a Map (useful for JSON parsing)
  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      passwordConfirmation: json['passwordConfirmation'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        firstname,
        lastname,
        email,
        password,
        passwordConfirmation,
        dob,
        gender,
        phoneNumber,
      ];
}
