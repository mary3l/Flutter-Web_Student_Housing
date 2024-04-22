//functions are:
// 1- checks if the user is already signed in using Google Auth
// 2- to authenticate the user using Google sign in with firebase api
// 3- retrieves general user information from their Google Account

// Note that the implemenetation only works for web
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

String? uid;
String? name;
String? userEmail;
// String? imageUrl;

Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp();

  User? user;

  // Google Sign-in for web
  if (kIsWeb) {
    final GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(authProvider);

      user = userCredential.user;
    } catch (e) {
      print(e);
    }
  } else {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credentials') {
          print("Account exists with different credentials");
        } else if (e.code == 'invalid-credentials') {
          print('Error: Invalid credentials');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  if (user != null) {
    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auth', true);
  }

  return user;
}

// For sign out methods using Google Sign in
void signOutGoogle() async {
  await googleSignIn.signOut();
  await FirebaseAuth.instance.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('auth', false);

  uid = null;
  name = null;
  userEmail = null;
  // imageUrl = null;

  print('User signed out');
}
