import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/schedule.dart';

class PracticalInfoModel extends Equatable {
  final String practiceAddress; // Practice address of the professional
  final List<Schedule> schedules; // List of schedules for the week
  final int consultationRate; // Consultation rate as an integer

  PracticalInfoModel({
    required this.practiceAddress,
    required this.schedules,
    required this.consultationRate,
  });

  // Convert PracticalInfoModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'practiceAddress': practiceAddress,
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
      'consultationRate': consultationRate,
    };
  }

  // Create PracticalInfoModel from JSON (Map)
  factory PracticalInfoModel.fromJson(Map<String, dynamic> json) {
    return PracticalInfoModel(
      practiceAddress: json['practiceAddress'] ?? '',
      schedules: (json['schedules'] as List)
          .map((item) => Schedule.fromJson(item))
          .toList(),
      consultationRate: json['consultationRate'] ?? 0,
    );
  }

  @override
  List<Object> get props => [practiceAddress, schedules, consultationRate];
}
