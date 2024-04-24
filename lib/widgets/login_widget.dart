import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_finals_web/screens/home.dart';
import 'package:flutter_finals_web/providers/auth_provider.dart';
import 'package:flutter_finals_web/widgets/google_sign_in_button.dart';

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
        width: 400,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20), // Add padding to the top
                  child: Text(
                    'College Dormitory Finder', // Title text
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color set to white
                    ),
                  ),
                ),
                SizedBox(height: 20), // Adjust spacing as needed
                GoogleButton(),
                if (isLoggingIn) CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
