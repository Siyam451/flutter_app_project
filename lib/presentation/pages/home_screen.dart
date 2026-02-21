import 'package:flutter/material.dart';
import '../../data/models/chat_model.dart';
import '../../domain/repositories/chat_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  final ChatRepository _repository = ChatRepository();

  final List<ChatModel> _messages = [];

  bool _loading = false;

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _loading) return;

    setState(() {
      _messages.add(ChatModel(role: "user", content: text));
      _messages.add(ChatModel(role: "assistant", content: "Typing..."));
      _loading = true;
      _controller.clear();
    });

    try {
      final reply = await _repository.sendMessage(_messages);

      setState(() {
        _messages.removeLast();
        _messages.add(ChatModel(role: "assistant", content: reply));
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messages.add(ChatModel(
          role: "assistant",
          content: e.toString(),
        ));
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Open AI")),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                final isUser = msg.role == "user";

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                      isUser ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      msg.content,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type message...",
                    ),
                  ),
                ),

                IconButton(
                  onPressed: _send,
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
