import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String apiKey = "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";
  final String endpoint = 'https://api.openai.com/v1/chat/completions';
  final String prompt =
      '''Steps walked : 20000 slept: 12hrs what changes to make to improve health  give output as json format and integers  only no extra values:\n{"sleep": sleep, "steps": steps }''';

  String assistantReply = '';

  Future<void> fetchAssistantReply() async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': prompt},
        ],
        'model': 'gpt-3.5-turbo',
      }),
    );

    final data = jsonDecode(response.body);
    if (data['choices'] != null && data['choices'].isNotEmpty) {
      setState(() {
        assistantReply = data['choices'][0]['message']['content'];
      });
    } else {
      setState(() {
        assistantReply = "No assistant reply found in the response.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenAI Chat Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                fetchAssistantReply();
              },
              child: Text('Get Assistant Reply'),
            ),
            SizedBox(height: 20),
            Text('Assistant Reply:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(assistantReply, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
