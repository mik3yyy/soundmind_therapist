class Referral {
  final int id;
  final int patientId;
  final int institutionName;
  final int institutionId;
  final String notes;
  final String fname;
  final String lname;

  final DateTime referralDate;

  Referral({
    required this.id,
    required this.patientId,
    required this.institutionId,
    required this.institutionName,
    required this.lname,
    required this.fname,
    required this.notes,
    required this.referralDate,
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      fname: json['firstName'],
      institutionName: json['institutionName'],
      id: json['id'],
      lname: json['lastName'],
      patientId: json['patientId'],
      institutionId: json['institutionId'],
      notes: json['notes'],
      referralDate: DateTime.parse(json['referralDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'patientId': patientId,
      'institutionId': institutionId,
      'notes': notes,
      'institutionName': institutionName,
      'referralDate': referralDate.toIso8601String(),
    };
  }
}
