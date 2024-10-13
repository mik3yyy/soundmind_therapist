class ChatMessage {
  final int senderId;
  final int chatId;
  final String message;
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  ChatMessage({
    required this.senderId,
    required this.chatId,
    required this.message,
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
  });

  // Factory constructor to create a ChatMessage from JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      senderId: json['senderId'],
      chatId: json['chatId'],
      message: json['message'],
      id: json['id'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
    );
  }
  // Factory constructor to create a ChatMessage from JSON
  factory ChatMessage.fromMessage(
      {required String message,
      required int chatId,
      required int senderId,
      required int receiverId}) {
    return ChatMessage(
      senderId: senderId,
      chatId: chatId,
      message: message,
      id: chatId,
      timeCreated: DateTime.now(),
      timeUpdated: DateTime.now(),
    );
  }

  // Method to convert a ChatMessage to JSON
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'chatId': chatId,
      'message': message,
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ChatMessage(senderId: $senderId, chatId: $chatId, message: $message, id: $id, timeCreated: $timeCreated, timeUpdated: $timeUpdated)';
  }
}
