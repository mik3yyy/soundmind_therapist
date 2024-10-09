class ChatRoom {
  final int chatRoomID;
  final int senderID;
  final int receiverID;
  final String senderProfilePhoto;
  final String senderName;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  ChatRoom({
    required this.chatRoomID,
    required this.senderID,
    required this.receiverID,
    required this.senderProfilePhoto,
    required this.senderName,
    required this.timeCreated,
    required this.timeUpdated,
  });

  // Factory method to create ChatRoom from JSON
  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatRoomID: json['chatRoomID'],
      senderID: json['senderID'],
      receiverID: json['receiverID'],
      senderProfilePhoto: json['senderProfilePhoto'] ?? '',
      senderName: json['senderName'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
    );
  }

  // Method to convert ChatRoom to JSON
  Map<String, dynamic> toJson() {
    return {
      'chatRoomID': chatRoomID,
      'senderID': senderID,
      'receiverID': receiverID,
      'senderProfilePhoto': senderProfilePhoto,
      'senderName': senderName,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
    };
  }
}
