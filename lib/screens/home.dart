import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Welcome, $userName!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      itemCount: housings.length,
                      itemBuilder: (context, index) {
                        return HousingCard(
                          housingId: housings[index].id,
                        );
                      },
                    );
                  },
                ),
              ),
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
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                LoginDialog()), // Navigate to the login screen after signing out
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Sign-out error: $error');
    }
  }
}
