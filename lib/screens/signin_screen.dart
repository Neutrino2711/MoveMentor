import 'package:flutter/material.dart';
import 'package:status_code0/models/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:status_code0/screens/activity.dart';
import 'package:status_code0/screens/nav_controller_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final userCheckProvider = Provider.of<GoogleSignInProvider>(context);

    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                child: Text(
                  "SignIn",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onPressed: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.googleLogin();
                  final user = FirebaseAuth.instance.currentUser;
                  debugPrint(user!.email);
                  if (user != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => HomePage())));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
