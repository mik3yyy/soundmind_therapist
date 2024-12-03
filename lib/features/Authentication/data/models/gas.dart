import 'dart:convert';

class GASModel {
  final String name;
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  GASModel({
    required this.name,
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
  });

  // Factory constructor to create an instance from a JSON map
  factory GASModel.fromJson(Map<String, dynamic> json) {
    return GASModel(
      name: json['name'] as String,
      id: json['id'] as int,
      timeCreated: DateTime.parse(json['timeCreated'] as String),
      timeUpdated: DateTime.parse(json['timeUpdated'] as String),
    );
  }

  // Method to convert an instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
    };
  }

  // Helper method to create a list of GASModel from JSON list
  static List<GASModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => GASModel.fromJson(json)).toList();
  }

  // Helper method to convert a list of GASModel into a JSON list
  static List<Map<String, dynamic>> listToJson(List<GASModel> list) {
    return list.map((item) => item.toJson()).toList();
  }
}

void main() {
  // Example JSON string
  String jsonString = '''
  {
    "name": "Group Therapy",
    "id": 20,
    "timeCreated": "2024-09-20T17:11:46.247472+00:00",
    "timeUpdated": "2024-09-20T17:11:46.247472+00:00"
  }
  ''';

  // Parse JSON string to Dart object
  Map<String, dynamic> jsonMap = json.decode(jsonString);
  GASModel gasModel = GASModel.fromJson(jsonMap);

  // Print parsed object
  print('Name: ${gasModel.name}');
  print('ID: ${gasModel.id}');
  print('Created: ${gasModel.timeCreated}');
  print('Updated: ${gasModel.timeUpdated}');

  // Convert object back to JSON
  String jsonOutput = json.encode(gasModel.toJson());
  print('JSON Output: $jsonOutput');
}
