// This directive tells the analyzer to ignore certain rules. You've ignored rules related
// to using const constructors and using build context synchronously.
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/userModel.dart';

/// `AuthService` class: Manages user authentication functions with Firebase and Google.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Helper method: Converts Firebase's User object to a custom AuthUser model.
  static AuthUser? _authUserFromFirebase(User? user) {
    if (user != null) {
      return AuthUser(
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          photoURL: user.photoURL);
    } else {
      return null;
    }
  }

  // Helper method: Creates a custom snackbar with a specific content message.
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  // Stream that emits AuthUser whenever the authentication state changes in Firebase.
  Stream<AuthUser?> get onAuthStateChanged {
    return _auth.authStateChanges().map(_authUserFromFirebase);
  }

  // Sign in user with email and password on Firebase.
  // Returns an AuthUser on success, null on failure.
  Future<AuthUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _authUserFromFirebase(credential.user);
    } catch (e) {
      print("Error during sign-in: $e");
      return null;
    }
  }

  // Create a new user account on Firebase with email and password.
  // Returns an AuthUser on success, null on failure.
  Future<AuthUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _authUserFromFirebase(credential.user);
    } catch (e) {
      print("Error during account creation: $e");
      return null;
    }
  }

  // Reset the password for the email account on Firebase.
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error resetting password: $e");
    }
  }

  // Sign in user using Google authentication.
  // Returns an AuthUser on success, null on failure.
  static Future<AuthUser?> signInWithGoogle(
      {required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    // Different procedures for web and non-web platforms.
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
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
              await auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          // Handle specific Firebase errors with meaningful messages.
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthService.customSnackBar(
                content:
                    'The account already exists with a different credential',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthService.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthService.customSnackBar(
              content: 'Error occurred using Google Sign In. Try again.',
            ),
          );
        }
      }
    }
    return _authUserFromFirebase(user);
  }

  // Sign out the currently authenticated user.
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthService.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}
