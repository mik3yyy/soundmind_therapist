import 'package:equatable/equatable.dart';

class Upload extends Equatable {
  final String path;
  final int type;

  Upload({
    required this.path,
    required this.type,
  });

  // Convert Upload to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'type': type,
    };
  }

  // Create Upload from JSON (Map)
  factory Upload.fromJson(Map<String, dynamic> json) {
    return Upload(
      path: json['path'] ?? '',
      type: json['type'] ?? 0,
    );
  }

  @override
  List<Object> get props => [path, type];
}
