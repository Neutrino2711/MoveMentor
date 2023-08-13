import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiIntegrate {
  ApiIntegrate(this.steps, this.sleep);

  String? steps;
  String? sleep;
  String? prompt;
  final String apiKey = "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";
  final String endpoint = 'https://api.openai.com/v1/chat/completions';

  String assistantReply = '';
  String real_reply = '';

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
      assistantReply = data['choices'][0]['message']['content'];
    } else {
      assistantReply = "No assistant reply found in the response.";
    }
  }
}
