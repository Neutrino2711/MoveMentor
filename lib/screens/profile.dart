import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:status_code0/models/api_integrate.dart';
import 'package:provider/provider.dart';
import 'package:status_code0/models/google_signin.dart';
import 'dart:math';

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
    required this.sleep,
    required this.steps,
    required this.weight,
    required this.height,
    required this.prompt,
  });

  final String sleep, steps, height;
  final int weight;
  final String prompt;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final String apiKey = "YOUR-API-KEY";
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
          {'role': 'user', 'content': widget.prompt},
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

  double BMI(String height, int weight) {
    print(height);
    print(weight);
    return (weight * 10000) /
        ((int.tryParse(height)!) * (int.tryParse(height)!));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // double BMI(String height, int weight) {}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final user = provider.user;

    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        CircleAvatar(
          radius: 45.0,
          child: Image.network(user.photoUrl!),
        ),
        Text(
          user.displayName!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Divider(
          thickness: 2.0,
        ),
        Text(
          "Male  21",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Divider(
          thickness: 2.0,
        ),
        Text(
          "Your BMI is ${BMI(widget.height, widget.weight).toString()}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Divider(
          thickness: 2.0,
        ),
        TextButton(
            onPressed: () {
              fetchAssistantReply();
            },
            child: Text(
              "Analyze ",
              style: Theme.of(context).textTheme.titleLarge,
            )),
        Card(
          child: Text(
            assistantReply,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ]),
    );
  }
}
