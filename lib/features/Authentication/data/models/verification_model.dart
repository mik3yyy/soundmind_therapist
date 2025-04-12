import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/upload.dart';

class VerificationInfoModel extends Equatable {
  final Upload license;
  final Upload govID;
  final Upload degree;
  final Upload profile;

  VerificationInfoModel({required this.license, required this.govID, required this.degree, required this.profile});

  // Convert VerificationInfoModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'license': license.toJson(),
      'govID': govID.toJson(),
      'degree': degree.toJson(),
      'profile': profile.toJson()
    };
  }

  // Create VerificationInfoModel from JSON (Map)
  factory VerificationInfoModel.fromJson(Map<String, dynamic> json) {
    return VerificationInfoModel(
        license: Upload.fromJson(json['license'] ?? {}),
        govID: Upload.fromJson(json['govID'] ?? {}),
        degree: Upload.fromJson(json['degree'] ?? {}),
        profile: Upload.fromJson(json['profile'] ?? {}));
  }

  @override
  List<Object> get props => [license, govID, degree];
}
