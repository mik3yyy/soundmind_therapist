import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/upload.dart';

class ProfileInfoModel extends Equatable {
  final Upload profilePicture;

  ProfileInfoModel({
    required this.profilePicture,
  });

  // Convert ProfileInfoModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'profilePicture': profilePicture.toJson(),
    };
  }

  // Create ProfileInfoModel from JSON (Map)
  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) {
    return ProfileInfoModel(
      profilePicture: Upload.fromJson(json['profilePicture'] ?? {}),
    );
  }

  @override
  List<Object> get props => [profilePicture];
}
