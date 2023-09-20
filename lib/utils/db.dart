// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_template/models/userModel.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<AppUser> streamAppUser(AuthUser authUser) {
    return _db
        .collection('users')
        .doc(authUser.uid)
        .snapshots()
        .map((document) => AppUser.fromMap(document, document.id));
  }

  /// Write data
  Future<void> createUser(AuthUser authUser) {
    CollectionReference users = _db.collection('users');
    return users
        // existing document in 'users' collection: "ABC123"
        .doc(authUser.uid)
        .set(
          {
            'displayName': authUser.displayName,
            'email': authUser.email,
            'photoURL': authUser.photoURL,
            'lastSeen': DateTime.now()
          },
          SetOptions(merge: true),
        )
        // ignore: avoid_print
        .then((value) => print("'Merge complete"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to merge data: $error"));
  }

  Future<AppUser?> getUser(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await _db.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return AppUser.fromMap(
            userSnapshot.data() as Map<String, dynamic>, uid);
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching user: $e");
      return null;
    }
  }

  Future<bool> doesUserExist(AuthUser authUser) async {
    final existingUser = await DatabaseService().getUser(authUser.uid);
    return existingUser != null;
  }
}
