import 'package:flutter/material.dart';
import 'package:flutter_finals_web/screens/home.dart';
import 'package:flutter_finals_web/services/auth.dart';
import 'package:flutter_finals_web/widgets/google_sign_in_button.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  //for states of the button like google sign in button

  //used for creating new account
  // bool isRegistering = false;
  bool isLoggingIn = false;

  String? loginStatus;
  // Color loginStringColor = Colors.green;

  //define a method to validate a

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleButton(),
            if (isLoggingIn) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
