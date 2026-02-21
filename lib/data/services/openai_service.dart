import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_model.dart';

class OpenAIService {
  static const String _apiKey = "YOUR_API_KEY";
  static const String _baseUrl =
      "https://api.openai.com/v1/chat/completions";

  Future<String> sendMessage(List<ChatModel> messages) async {
    final uri = Uri.parse(_baseUrl);

    final body = {
      "model": "gpt-4o-mini",
      "messages": messages.map((e) => e.toJson()).toList(),
      "temperature": 0.7,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_apiKey",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['error']?['message']);
    }

    final data = jsonDecode(response.body);

    return data["choices"][0]["message"]["content"];
  }
}
