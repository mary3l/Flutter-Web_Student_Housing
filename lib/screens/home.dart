import 'package:flutter/material.dart';
import 'package:flutter_finals_web/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white, // Text color set to white
          ),
        ),
        backgroundColor: Colors.grey[900], // App bar color set to orange
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.jpg", // Replace with your image path
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Card(
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome, $userName!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 40), // Adjust the height for spacing
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _signOut(context);
                            },
                            child: Text('Sign Out'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      signOutGoogle();
      Navigator.popUntil(
          context,
          ModalRoute.withName(
              Navigator.defaultRouteName)); // Go back to the root route
    } catch (error) {
      print('Sign-out error: $error');
    }
  }
}
