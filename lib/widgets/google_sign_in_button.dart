import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_finals_web/screens/home.dart';
import 'package:flutter_finals_web/providers/auth_provider.dart'; // Import AuthProvider

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => _signInWithGoogle(context),
        icon: Icon(Icons.login),
        label: Text('Login Using Google'),
      ),
    );
  }

  void _signInWithGoogle(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signInWithGoogle();

    final user = authProvider.user;
    if (user != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }
}
