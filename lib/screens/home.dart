import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_finals_web/screens/items.dart';
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
          color: Colors.indigo[900],
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
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .orange, // Set the background color to orange
                            ),
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors
                                    .black, // Set the text color to orange
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Houses with Dorm rooms',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemScreen()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.3, // 80% of screen width
                            height: MediaQuery.of(context).size.height *
                                0.4, // 40% of screen height
                            child: Card(
                              color: Colors.grey[900],
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/bg.jpg', // Replace with your image asset
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Your Title',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
