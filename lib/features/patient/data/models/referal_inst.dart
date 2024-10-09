class ReferralInstitution {
  final String name;
  final int institutionType;
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  ReferralInstitution({
    required this.name,
    required this.institutionType,
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
  });

  factory ReferralInstitution.fromJson(Map<String, dynamic> json) {
    return ReferralInstitution(
      name: json['name'],
      institutionType: json['institutionType'],
      id: json['id'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'institutionType': institutionType,
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
    };
  }
}
