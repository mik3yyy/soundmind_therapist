class Referral {
  final int id;
  final int patientId;
  final int institutionId;
  final String notes;
  final DateTime referralDate;

  Referral({
    required this.id,
    required this.patientId,
    required this.institutionId,
    required this.notes,
    required this.referralDate,
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'],
      patientId: json['patientId'],
      institutionId: json['institutionId'],
      notes: json['notes'],
      referralDate: DateTime.parse(json['referralDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'institutionId': institutionId,
      'notes': notes,
      'referralDate': referralDate.toIso8601String(),
    };
  }
}
