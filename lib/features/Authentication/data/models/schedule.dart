import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

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

class ScheduleTEMP extends Equatable {
  final List<int>?
      dayOfWeek; // Day of the week as an integer (e.g., 1 = Monday, 7 = Sunday)
  final String? startTime; // Start time in string format (e.g., "09:00 AM")
  final String? endTime; // End time in string format (e.g., "05:00 PM")

  ScheduleTEMP({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory ScheduleTEMP.empty() {
    return ScheduleTEMP(dayOfWeek: [], startTime: null, endTime: null);
  }
  // Convert ScheduleTEMP to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  bool isSet() {
    return dayOfWeek != null && startTime != null && endTime != null;
  }

  bool isOkay() {
    print(startTime);
    print(endTime);
    DateTime start = parseTimeString(startTime!);
    DateTime end = parseTimeString(endTime!);
    return start.isBefore(end);
  }

  DateTime parseTimeString(String timeString) {
    final format = DateFormat('hh:mm a'); // Correcting the format to 'hh:mm a'
    return format.parse(timeString);
  }

  @override
  String toString() {
    return '${dayOfWeek?.join('')}-${startTime}-${endTime}';
  }

  @override
  List<Object?> get props => [dayOfWeek, startTime, endTime];
}
