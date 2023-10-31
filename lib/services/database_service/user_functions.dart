// ignore_for_file: avoid_print

part of database_service;

extension UserOperations on DatabaseService {
  // Create a new AppUser and store it in the database
  // Create a new AppUser and store it in the database
  Future<void> createUser(AuthUser authUser) {
    return DatabaseService.db.collection('users').doc(authUser.uid).set({
      'displayName': authUser.displayName,
      'email': authUser.email,
      'photoURL': authUser.photoURL,
      'accountType': 'basic',
      'lastSeen': DateTime.now(),
    }, SetOptions(merge: true)).then((value) => print('''
############### FIREBASE FIRED - createUser in user_functions.dart
'''));
  }

  // Retrieve AppUser data using uid from the database
  Future<AppUser?> getUser(String uid) async {
    DocumentSnapshot userSnapshot =
        await DatabaseService.db.collection('users').doc(uid).get();
    if (userSnapshot.exists) {
      print('''
############### FIREBASE FIRED - getUser in user_functions.dart
''');
      return AppUser.fromMap(userSnapshot.data() as Map<String, dynamic>, uid);
    }
    return null;
  }

  // Create a new AppUser if not existing and fetch its data
  Future<AppUser?> createUserAndFetch(AuthUser authUser) async {
    AppUser? appUser = await getUser(authUser.uid);
    if (appUser == null) {
      await createUser(authUser);
      appUser = AppUser(
        uid: authUser.uid,
        email: authUser.email,
        displayName: authUser.displayName,
        photoURL: authUser.photoURL,
        lastSeen: Timestamp.fromDate(DateTime.now()),
      );
    }
    return appUser;
  }

  // Toggle the account type for an AppUser
  Future<void> toggleAccountType(String uid) async {
    DocumentReference userRef = DatabaseService.db.collection('users').doc(uid);
    DocumentSnapshot userSnapshot = await userRef.get();
    String currentType = userSnapshot['accountType'] ?? 'basic';
    await userRef.update({
      'accountType': currentType == 'basic' ? 'premium' : 'basic'
    }).then((value) => print('''
############### FIREBASE FIRED - toggleAccountType in user_functions.dart
'''));
  }

  // Check if a user exists in the database
  Future<bool> doesUserExist(AuthUser authUser) async {
    return await getUser(authUser.uid) != null;
  }

  // Fetch all AppUser data stored in the database
  Future<List<AppUser>> fetchAllUsers() async {
    QuerySnapshot querySnapshot =
        await DatabaseService.db.collection('users').get();
    print('''
############### FIREBASE FIRED - fetchAllUsers in user_functions.dart
''');
    return querySnapshot.docs
        .map((doc) =>
            AppUser.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Request to share a bot with a user
  Future<void> addPendingShare(
      String botId, String sharerId, String sharerName, String userId) async {
    await DatabaseService.db.collection('bots').doc(botId).update({
      'permissions.user': FieldValue.arrayUnion([userId]),
      'permissions.pending_share': FieldValue.arrayUnion([
        {'sharer_id': sharerId, 'sharer_name': sharerName, 'user_id': userId}
      ]),
    }).then((value) => print('''
############### FIREBASE FIRED - addPendingShare in user_functions.dart
'''));
  }

  // Accept a bot share request
  Future<void> acceptPendingShare(
      String botId, String sharerId, String sharerName, String userId) async {
    return await DatabaseService.db.collection('bots').doc(botId).update({
      'permissions.pending_share': FieldValue.arrayRemove([
        {'sharer_id': sharerId, 'sharer_name': sharerName, 'user_id': userId}
      ]),
    }).then((value) => print('''
############### FIREBASE FIRED - acceptPendingShare in user_functions.dart
'''));
  }

  // Reject a bot share request
  Future<void> removeFromPendingShare(
      String botId, String sharerId, String sharerName, String userId) async {
    return await DatabaseService.db.collection('bots').doc(botId).update({
      'permissions.user': FieldValue.arrayRemove([userId]),
      'permissions.pending_share': FieldValue.arrayRemove([
        {'sharer_id': sharerId, 'sharer_name': sharerName, 'user_id': userId}
      ]),
    }).then((value) => print('''
############### FIREBASE FIRED - removeFromPendingShare in user_functions.dart
'''));
  }
}
