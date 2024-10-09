class MetricsModel {
  final int patients;
  final int appointments;
  final int reSchedules;
  final int referredPatients;

  MetricsModel({
    required this.patients,
    required this.appointments,
    required this.reSchedules,
    required this.referredPatients,
  });

  // Factory method to create MetricsModel from JSON
  factory MetricsModel.fromJson(Map<String, dynamic> json) {
    return MetricsModel(
      patients: json['patients'],
      appointments: json['appointments'],
      reSchedules: json['reSchedules'],
      referredPatients: json['referredPatients'],
    );
  }

  // Method to convert MetricsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'patients': patients,
      'appointments': appointments,
      'reSchedules': reSchedules,
      'referredPatients': referredPatients,
    };
  }
}
