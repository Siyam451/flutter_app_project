import '../../data/models/chat_model.dart';
import '../../data/services/openai_service.dart';

class ChatRepository {
  final OpenAIService _service = OpenAIService();

  Future<String> sendMessage(List<ChatModel> messages) async {
    return await _service.sendMessage(messages);
  }
}
