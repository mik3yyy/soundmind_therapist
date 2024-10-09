class Note {
  final int id;
  final int userID;
  final String message;
  final String doctorName;

  Note({
    required this.id,
    required this.userID,
    required this.message,
    required this.doctorName,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      userID: json['userID'],
      message: json['message'],
      doctorName: json['doctorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'message': message,
      'doctorName': doctorName,
    };
  }
}
