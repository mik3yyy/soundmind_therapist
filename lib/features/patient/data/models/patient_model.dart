import 'package:soundmind_therapist/features/patient/data/models/not.dart';

class PatientModel {
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final int severity;
  final int age;
  final double rating;
  final List<Note> notes;
  final bool hasNotesAccess;
  final List<String> referrals;

  PatientModel({
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    required this.severity,
    required this.age,
    required this.rating,
    required this.notes,
    required this.hasNotesAccess,
    required this.referrals,
  });

  // Factory method to create PatientModel from JSON

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return PatientModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
      severity: json['severity'],
      age: json['age'],
      rating: (json['rating'] as num).toDouble(),
      notes: (json['notes'] as List).map((e) => Note.fromJson(e)).toList(),
      hasNotesAccess: json['hasNotesAccess'],
      referrals: List<String>.from(json['referrals']),
    );
  }

  // Method to convert PatientModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'severity': severity,
      'age': age,
      'rating': rating,
      'notes': notes,
      'hasNotesAccess': hasNotesAccess,
      'referrals': referrals,
    };
  }
}
