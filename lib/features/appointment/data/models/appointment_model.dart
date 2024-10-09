import 'dart:convert';

class AppointmentModel {
  final Booking booking;
  final Schedule schedule;
  final String patientName;
  final String? profilePicture;
  final String? areaOfSpecialization;

  AppointmentModel({
    required this.booking,
    required this.schedule,
    required this.patientName,
    this.profilePicture,
    this.areaOfSpecialization,
  });

  // Factory constructor to create an AppointmentModel from a JSON object
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      booking: Booking.fromJson(json['booking']),
      schedule: Schedule.fromJson(json['schedule']),
      patientName: json['patientName'],
      profilePicture: json['profilePicture'],
      areaOfSpecialization: json['areaOfSpecialization'],
    );
  }

  // Method to convert AppointmentModel to JSON object
  Map<String, dynamic> toJson() {
    return {
      'booking': booking.toJson(),
      'schedule': schedule.toJson(),
      'patientName': patientName,
      'profilePicture': profilePicture,
      'areaOfSpecialization': areaOfSpecialization,
    };
  }

  // Method to convert a JSON string to AppointmentModel
  static AppointmentModel fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return AppointmentModel.fromJson(jsonData);
  }

  // Method to convert AppointmentModel to JSON string
  String toJsonString() {
    final jsonData = toJson();
    return json.encode(jsonData);
  }
}

class Booking {
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;
  final int physicianId;
  final int physicianUserId;
  final int patientId;
  final int scheduleId;
  final DateTime date;
  final int status;
  final int paymentStatus;
  final double amount;
  final String? notes;
  final String? link;
  final String? transactionReference;
  final String? code;

  Booking({
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
    required this.physicianId,
    required this.physicianUserId,
    required this.patientId,
    required this.scheduleId,
    required this.date,
    required this.status,
    required this.paymentStatus,
    required this.amount,
    this.notes,
    this.link,
    this.transactionReference,
    this.code,
  });

  // Factory constructor to create a Booking from a JSON object
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
      physicianId: json['physicianId'],
      physicianUserId: json['physicianUserID'],
      patientId: json['patientId'],
      scheduleId: json['scheduleId'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      amount: (json['amount'] as num).toDouble(),
      notes: json['notes'],
      link: json['link'],
      transactionReference: json['transactionReference'],
      code: json['code'],
    );
  }

  // Method to convert Booking to JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
      'physicianId': physicianId,
      'physicianUserID': physicianUserId,
      'patientId': patientId,
      'scheduleId': scheduleId,
      'date': date.toIso8601String(),
      'status': status,
      'paymentStatus': paymentStatus,
      'amount': amount,
      'notes': notes,
      'link': link,
      'transactionReference': transactionReference,
      'code': code,
    };
  }
}

class Schedule {
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;
  final int physicianId;
  final int userId;
  final int dayOfWeek;
  final bool isTaken;
  final String dayOfWeekTitle;
  final String startTime;
  final String endTime;

  Schedule({
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
    required this.physicianId,
    required this.userId,
    required this.dayOfWeek,
    required this.isTaken,
    required this.dayOfWeekTitle,
    required this.startTime,
    required this.endTime,
  });

  // Factory constructor to create a Schedule from a JSON object
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
      physicianId: json['physicianId'],
      userId: json['userId'],
      dayOfWeek: json['dayOfWeek'],
      isTaken: json['isTaken'],
      dayOfWeekTitle: json['dayOfWeekTitle'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  // Method to convert Schedule to JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
      'physicianId': physicianId,
      'userId': userId,
      'dayOfWeek': dayOfWeek,
      'isTaken': isTaken,
      'dayOfWeekTitle': dayOfWeekTitle,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
