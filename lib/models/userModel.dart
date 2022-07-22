// ignore_for_file: file_names

class AuthUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  AuthUser({required this.uid, this.email, this.displayName, this.photoURL});
}

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final DateTime lastSeen;

  AppUser(
      {required this.uid,
      this.email,
      this.displayName,
      this.photoURL,
      required this.lastSeen});
}
