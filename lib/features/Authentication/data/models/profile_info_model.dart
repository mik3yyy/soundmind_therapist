import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/upload.dart';

class ProfileInfoModel extends Equatable {
  final String bio;
  final Upload profilePicture;

  ProfileInfoModel({
    required this.bio,
    required this.profilePicture,
  });

  // Convert ProfileInfoModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'bio': bio,
      'profilePicture': profilePicture.toJson(),
    };
  }

  // Create ProfileInfoModel from JSON (Map)
  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) {
    return ProfileInfoModel(
      bio: json['bio'] ?? '',
      profilePicture: Upload.fromJson(json['profilePicture'] ?? {}),
    );
  }

  @override
  List<Object> get props => [bio, profilePicture];
}
