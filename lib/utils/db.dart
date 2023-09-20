// This directive tells the analyzer to ignore the rule about not having underscores in local identifiers.
// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_template/models/userModel.dart';

/// `DatabaseService` class: A utility class to interact with Firestore database.
class DatabaseService {
  final FirebaseFirestore _db =
      FirebaseFirestore.instance; // Firestore instance.

  /// Stream to fetch real-time updates of an AppUser from Firestore.
  Stream<AppUser> streamAppUser(AuthUser authUser) {
    return _db
        .collection('users')
        .doc(authUser.uid)
        .snapshots() // Returns stream of document snapshots.
        .map((document) => AppUser.fromMap(document, document.id));
  }

  /// Create or update user data in Firestore.
  /// If the document already exists, it merges the new data with the old one.
  Future<void> createUser(AuthUser authUser) {
    CollectionReference users = _db.collection('users');
    return users
        .doc(authUser.uid)
        .set(
          {
            'displayName': authUser.displayName,
            'email': authUser.email,
            'photoURL': authUser.photoURL,
            'lastSeen': DateTime.now()
          },
          SetOptions(
              merge: true), // Merges with existing data if document exists.
        )
        .then((value) => print("'Merge complete"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  /// Helper method that creates a user and then immediately fetches the newly created/updated user.
  Future<AppUser?> createUserAndFetch(AuthUser authUser) async {
    await DatabaseService().createUser(authUser);
    return DatabaseService()
        .getUser(authUser.uid); // Assuming getUser returns a Future<AppUser?>
  }

  /// Fetches a user from Firestore based on UID.
  Future<AppUser?> getUser(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await _db.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return AppUser.fromMap(
            userSnapshot.data() as Map<String, dynamic>, uid);
      } else {
        return null; // Returns null if user doesn't exist.
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  /// Check if a user exists in Firestore based on their UID.
  Future<bool> doesUserExist(AuthUser authUser) async {
    final existingUser = await DatabaseService().getUser(authUser.uid);
    return existingUser != null;
  }
}
