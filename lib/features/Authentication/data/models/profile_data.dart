class ProfileData {
  bool personalInformationCompleted;
  bool practiceInformationCompleted;
  bool professionalInformationCompleted;
  bool verificationDocumentCompleted;

  // Constructor with default values set to true.
  ProfileData({
    required this.personalInformationCompleted,
    required this.practiceInformationCompleted,
    required this.professionalInformationCompleted,
    required this.verificationDocumentCompleted,
  });

  // Factory constructor to create an instance from JSON data.
  factory ProfileData.fromJson(Map<String, dynamic> dev) {
    var json = dev['data'];

    return ProfileData(
      personalInformationCompleted: json['personalInformationCompleted'] ?? true,
      practiceInformationCompleted: json['practiceInformationCompleted'] ?? true,
      professionalInformationCompleted: json['professionalInformationCompleted'] ?? true,
      verificationDocumentCompleted: json['verificationDocumentCompleted'] ?? true,
    );
  }

  // Method to convert the model instance to JSON.
  Map<String, dynamic> toJson() {
    return {
      'personalInformationCompleted': personalInformationCompleted,
      'practiceInformationCompleted': practiceInformationCompleted,
      'professionalInformationCompleted': professionalInformationCompleted,
      'verificationDocumentCompleted': verificationDocumentCompleted,
    };
  }
}
