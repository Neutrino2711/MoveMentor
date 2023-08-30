import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:status_code0/models/api_integrate.dart';
import 'package:provider/provider.dart';
import 'package:status_code0/models/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:status_code0/models/user_data.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:status_code0/screens/signin_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
    required this.prompt,
  });

  final String prompt;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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

  double BMI(int height, int weight) {
    print(height);
    print(weight);
    return (weight * 10000) / (height * height);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  // double BMI(String height, int weight) {}

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context);

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
        const Divider(
          thickness: 2.0,
        ),
        Text(
          "Male  21",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Divider(
          thickness: 2.0,
        ),
        TextButton(
          child: Text(
            "Calculate BMI",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          onPressed: () {
            String date = DateFormat.yMMMd().format(DateTime.now()).toString();
            userProvider.fetchEntries(date, user.email);
          },
        ),
        const Divider(
          thickness: 2.0,
        ),
        Text(
          userProvider.Userentries.isNotEmpty
              ? "Your BMI is ${BMI(userProvider.Userentries[0].height, userProvider.Userentries[0].weight).toString()}"
              : "No Data",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Divider(
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
        TextButton(
          child: Text(
            "Logout",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          onPressed: () async {
            await provider.googleLogout();
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return LoginPage();
            })));
          },
        ),
      ]),
    );
  }
}
