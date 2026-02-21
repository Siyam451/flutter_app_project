class ChatModel {
  final String role;
  final String content;

  ChatModel({
    required this.role,
    required this.content,
  });

  Map<String, String> toJson() {
    return {
      "role": role,
      "content": content,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      role: json["role"],
      content: json["content"],
    );
  }
}
