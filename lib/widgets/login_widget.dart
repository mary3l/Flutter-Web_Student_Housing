import 'package:flutter/material.dart';
import 'package:flutter_finals_web/providers/auth_provider.dart';
import 'package:flutter_finals_web/screens/home.dart';
import 'package:flutter_finals_web/widgets/google_sign_in_button.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  bool isLoggingIn = false;

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
