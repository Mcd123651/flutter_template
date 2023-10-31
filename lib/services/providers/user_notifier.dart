import 'package:flutter/foundation.dart';
import 'package:flutter_template/models/userModel.dart';
import 'package:flutter_template/services/database_service.dart';

/// This class manages the state of an AppUser. When the AppUser is fetched or updated,
/// it updates the internal AppUser state and notifies its listeners.
class UserNotifier with ChangeNotifier {
  AppUser? _appUser;
  final _dbService = DatabaseService();
  bool _disposed = false;

  /// Getter to access the current AppUser.
  AppUser? get appUser => _appUser;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Fetches the user from the database or creates one if it doesn't exist.
  /// Then updates the internal AppUser state.
  Future<void> fetchOrCreateUser(AuthUser authUser) async {
    AppUser fetchedAppUser =
        await _dbService.createUserAndFetch(authUser) as AppUser;
    if (!_disposed) {
      _appUser = fetchedAppUser;
      notifyListeners();
    }
  }

  /// Refreshes the AppUser by fetching or creating it again.
  void refreshUser(AuthUser authUser) => fetchOrCreateUser(authUser);
}
