import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/core/utils/cloudinary.dart';

class Upload extends Equatable {
  final String path;
  final int type;
  final int purpose;
  Upload({required this.path, required this.type, required this.purpose});

  // Convert Upload to JSON (Map)
  Map<String, dynamic> toJson() {
    return {'path': path, 'type': type, 'uploadPurpose': purpose};
  }

  Future<Map<String, dynamic>?> toUploadJson(
      String email, String purposes) async {
    String? newPath =
        await CloudinaryUtil.uplaodTOCloundinary(path, email, purposes);
    if (newPath == null) return null;
    return {'path': newPath, 'UploadType': type, 'uploadPurpose': purpose};
  }

  // Create Upload from JSON (Map)
  factory Upload.fromJson(Map<String, dynamic> json) {
    return Upload(
      path: json['path'] ?? '',
      type: json['type'] ?? 0,
      purpose: json['uploadPurpose'] ?? 1,
    );
  }

  @override
  List<Object> get props => [path, type];
}
