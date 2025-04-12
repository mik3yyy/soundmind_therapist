import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/qualification.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/schedule.dart';

class PracticalInfoModel extends Equatable {
  final List<Schedule> schedules; // List of schedules for the week
  final List<Qualification> qualifications;

  PracticalInfoModel({
    required this.schedules,
    required this.qualifications,
  });

  // Convert PracticalInfoModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
      'qualifications': qualifications.map((q) => q.toJson()).toList(),
    };
  }

  // // Create PracticalInfoModel from JSON (Map)
  // factory PracticalInfoModel.fromJson(Map<String, dynamic> json) {
  //   return PracticalInfoModel(

  //     schedules: (json['schedules'] as List).map((item) => Schedule.fromJson(item)).toList(),
  //   );
  // }

  @override
  List<Object> get props => [schedules];
}
