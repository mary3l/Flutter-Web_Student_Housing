import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;
  String? _username; // Add username variable

  User? get user => _user;
  String? get username => _username;

  // Constructor
  AuthProvider() {
    // Initialize user when the class is instantiated
    _user = _auth.currentUser;
    _username = _user?.displayName; // Initialize username if available
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        _user = userCredential.user;
        _username = _user?.displayName;
        notifyListeners();
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    _username = null;

    notifyListeners();
  }
}
