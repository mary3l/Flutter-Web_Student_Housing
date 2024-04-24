import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_finals_web/widgets/login_widget.dart';

Future<void> main() async {
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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Define a method for getting user info

  Future<void> getUserInfo() async {
    // Call your method to get user info here
    // For example:
    await getUser();
    // Ensure to replace `getUser()` with the actual method you use
    setState(() {});
    // If needed, call setState after updating state
    print(uid);
    // Print user ID or any user info
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chavez_Mabano_Final_Flutter_Exam',
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/bg.jpg"), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: LoginDialog(),
        ),
      ),
    );
  }
}

Future<void> getUser() async {}
String uid = '';
