import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/qualification.dart';

class ProfessionalInfoModel extends Equatable {
  final String licenseNum;
  final String issuingAuthority;
  final List<Qualification> qualifications;
  final int yoe; // Years of experience
  final String professionalAffiliation;
  final String aos; // Area of specialization

  ProfessionalInfoModel({
    required this.licenseNum,
    required this.issuingAuthority,
    required this.qualifications,
    required this.yoe,
    required this.professionalAffiliation,
    required this.aos,
  });

  // Convert ProfessionalInfoModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'licenseNum': licenseNum,
      'issuingAuthority': issuingAuthority,
      'qualifications': qualifications.map((q) => q.toJson()).toList(),
      'yoe': yoe,
      'professionalAffiliation': professionalAffiliation,
      'aos': aos,
    };
  }

  // Create ProfessionalInfoModel from JSON (Map)
  factory ProfessionalInfoModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalInfoModel(
      licenseNum: json['licenseNum'] ?? '',
      issuingAuthority: json['issuingAuthority'] ?? '',
      qualifications: (json['qualifications'] as List)
          .map((item) => Qualification.fromJson(item))
          .toList(),
      yoe: json['yoe'] ?? 0,
      professionalAffiliation: json['professionalAffiliation'] ?? '',
      aos: json['aos'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        licenseNum,
        issuingAuthority,
        qualifications,
        yoe,
        professionalAffiliation,
        aos
      ];
}
