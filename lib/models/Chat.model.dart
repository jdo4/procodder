
class ChatMessage {
  late String message;
  late int chat;
  late String time;

  ChatMessage({
    required this.message,
    required this.chat,
    required this.time,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'],
      chat: json['chat'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'chat': chat,
      'time': time,
    };
  }
}