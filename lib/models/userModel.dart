// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });
}

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final Timestamp lastSeen;

  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    required this.lastSeen,
  });

  factory AppUser.fromMap(data, String id) {
    data = data ?? {};
    return AppUser(
      uid: id,
      email: data['email'],
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      lastSeen: data['lastSeen'],
    );
  }
}
