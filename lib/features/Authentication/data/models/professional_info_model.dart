import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/qualification.dart';

class ProfessionalInfoModel extends Equatable {
  final String licenseNum;
  final String issuingAuthority;
  final int yoe; // Years of experience
  final String professionalAffiliation;
  final String licenseExpiryDate;
  final String aos; // Area of specialization
  final int consultationRate; // Consultation rate as an integer
  final String bio;
  final String practiceAddress; // Practice address of the professional

  ProfessionalInfoModel(
      {required this.licenseNum,
      required this.issuingAuthority,
      required this.licenseExpiryDate,
      required this.yoe,
      required this.professionalAffiliation,
      required this.aos,
      required this.consultationRate,
      required this.practiceAddress,
      required this.bio});

  // Convert ProfessionalInfoModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'licenseNum': licenseNum,
      'issuingAuthority': issuingAuthority,
      'yoe': yoe,
      "licenseExpiryDate": licenseExpiryDate,
      'professionalAffiliation': professionalAffiliation,
      'aos': aos,
      'bio': bio,
      "consultationRate": consultationRate,
      "placeOfWork": practiceAddress,
      "clinicAddress": practiceAddress,
    };
  }

  // // Create ProfessionalInfoModel from JSON (Map)
  // factory ProfessionalInfoModel.fromJson(Map<String, dynamic> json) {
  //   return ProfessionalInfoModel(
  //     licenseNum: json['licenseNum'] ?? '',
  //     issuingAuthority: json['issuingAuthority'] ?? '',
  //     qualifications: (json['qualifications'] as List)
  //         .map((item) => Qualification.fromJson(item))
  //         .toList(),
  //     yoe: json['yoe'] ?? 0,
  //     professionalAffiliation: json['professionalAffiliation'] ?? '',
  //     aos: json['aos'] ?? '',
  //     licenseExpiryDate: json['licenseExpiryDate'] ?? '',
  //   );
  // }

  @override
  List<Object> get props => [licenseNum, issuingAuthority, yoe, professionalAffiliation, aos];
}
