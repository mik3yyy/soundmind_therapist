import 'package:equatable/equatable.dart';

class Qualification extends Equatable {
  final String schoolName;
  final String degree;
  final String startDate;
  final String endDate;

  Qualification({
    required this.schoolName,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });

  // Convert Qualification to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'degree': degree,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  // Create Qualification from JSON (Map)
  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      schoolName: json['schoolName'] ?? '',
      degree: json['degree'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }

  @override
  List<Object> get props => [schoolName, degree, startDate, endDate];
}
