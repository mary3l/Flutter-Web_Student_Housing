import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finals_web/widgets/create_button.dart';
import 'package:flutter_finals_web/widgets/login_widget.dart';
import 'package:flutter_finals_web/widgets/housing_card.dart';

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
        backgroundColor: Colors.grey[900], // App bar color set to grey
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10), // Set the border radius to 10
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Welcome, $userName!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(child: CreateButton()

                      //     Text(
                      //   'test',
                      //   style: TextStyle(fontSize: 24),
                      // )
                      ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _signOut(context);
                      },
                      child: Text('Sign Out'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('student housings')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List<DocumentSnapshot> housings =
                        snapshot.data!.docs.toList();

                    return ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Set scroll direction to horizontal
                      itemCount: housings.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width *
                              0.3, // 80% of screen width
                          height: MediaQuery.of(context).size.height *
                              0.4, // 40% of screen height // Set the height of the card
                          child: HousingCard(
                            housingId: housings[index].id,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) =>
              LoginDialog(), // Navigate to the login screen after signing out
        ),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Sign-out error: $error');
    }
  }
}
