import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_model.dart';

class LocalStorageService {
  static const String _chatKey = "chat_messages";

  // Save messages
  Future<void> saveMessages(List<ChatModel> messages) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList =
    messages.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(_chatKey, jsonList);
  }

  // Load messages
  Future<List<ChatModel>> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList(_chatKey);

    if (jsonList == null) return [];

    return jsonList.map((e) {
      final map = jsonDecode(e);
      return ChatModel.fromJson(map);
    }).toList();
  }

  // Clear chat
  Future<void> clearMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chatKey);
  }
}
