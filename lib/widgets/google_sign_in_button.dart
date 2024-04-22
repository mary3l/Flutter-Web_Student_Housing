import 'package:flutter/material.dart';
import 'package:flutter_finals_web/screens/home.dart';
import 'package:flutter_finals_web/services/auth.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _isProcessing ? null : _signInWithGoogle,
        icon: Icon(Icons.login),
        label: Text('Login Using Google'),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final result = await signInWithGoogle();
      if (result != null) {
        _navigateToHomeScreen(
            result.displayName ?? ''); // Pass the user's name here
      }
    } catch (error) {
      print('Sign-in error: $error');
      // Handle sign-in error
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _navigateToHomeScreen(String userName) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) =>
            HomeScreen(userName: userName), // Pass the userName here
      ),
    );
  }
}
