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
        .then((value) => print("'Merge complete"))
        .catchError((error) => print("Failed to merge data: $error"));
  }
}
