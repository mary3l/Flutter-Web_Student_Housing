import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finals_web/widgets/login_widget.dart';
import 'package:flutter_finals_web/providers/auth_provider.dart'; // Import AuthProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB2ye5vscFm1eiOiPVBIQ8np-CnGNk4DQc",
      authDomain: "student-housing-db.firebaseapp.com",
      projectId: "student-housing-db",
      messagingSenderId: "997141921548",
      appId: "1:997141921548:web:09ad4be66b79bed6e8d329",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider(
        // Wrap your root widget with ChangeNotifierProvider
        create: (context) =>
            AuthProvider(), // Provide an instance of AuthProvider
        child: LoginDialog(), // Set LoginDialog as the initial screen
      ),
    );
  }
}
