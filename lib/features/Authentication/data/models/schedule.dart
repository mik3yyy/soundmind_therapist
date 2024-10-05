import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final int
      dayOfWeek; // Day of the week as an integer (e.g., 1 = Monday, 7 = Sunday)
  final String startTime; // Start time in string format (e.g., "09:00 AM")
  final String endTime; // End time in string format (e.g., "05:00 PM")

  Schedule({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  // Convert Schedule to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  // Create Schedule from JSON (Map)
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      dayOfWeek: json['dayOfWeek'] ?? 1,
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }

  @override
  List<Object> get props => [dayOfWeek, startTime, endTime];
}
