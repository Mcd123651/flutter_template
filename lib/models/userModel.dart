// Directive to ignore the file naming convention for this file.
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

/// `AuthUser` class: Model representing authenticated user data.
class AuthUser {
  final String uid; // Unique identifier of the user.
  final String? email; // Email address of the user (optional).
  final String? displayName; // Display name of the user (optional).
  final String? photoURL; // URL to the user's profile photo (optional).

  // Constructor to initialize `AuthUser` object.
  AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });
}

/// `AppUser` class: Model representing an app user with additional data.
class AppUser {
  final String uid; // Unique identifier of the app user.
  final String? email; // Email address of the app user (optional).
  final String? displayName; // Display name of the app user (optional).
  final String? photoURL; // URL to the app user's profile photo (optional).
  final Timestamp lastSeen; // Timestamp of the last activity of the user.

  // Constructor to initialize `AppUser` object.
  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    required this.lastSeen,
  });

  // Factory constructor to create an instance of `AppUser` from a map (often used to construct object from Firestore data).
  factory AppUser.fromMap(data, String id) {
    data = data ?? {};
    return AppUser(
      uid: id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoURL: data['photoURL'],
      lastSeen: data['lastSeen'],
    );
  }
}
