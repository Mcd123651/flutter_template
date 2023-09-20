import 'package:flutter/material.dart';
import 'package:flutter_template/screens/login/login_screen.dart';
import 'package:flutter_template/utils/db.dart';
import 'package:flutter_template/utils/router.dart';
import 'package:provider/provider.dart';
import 'models/userModel.dart';

// identify if authenticated.
// if not auth: go to sign in screen
// if auth: stream the AppUser ( Wrapper 2 )
class AuthWrapper extends StatelessWidget {
  AuthWrapper({Key? key}) : super(key: key);

  final _dbService = DatabaseService(); // Single instance

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthUser?>(context);
    if (authUser == null) {
      return const LoginScreen();
    } else {
      return FutureBuilder<bool>(
        future: _dbService.doesUserExist(authUser),
        builder: (context, snapshot) {
          // If we're still waiting for the check, return a loader
          if (!snapshot.hasData) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            );
          }

          // If the user doesn't exist in the DB, create them
          if (!snapshot.data!) {
            DatabaseService().createUser(authUser);
          }

          // Now proceed to stream the AppUser
          return StreamProvider<AppUser?>.value(
            initialData: null,
            value: DatabaseService().streamAppUser(authUser),
            child: const UserDataWrapper(),
          );
        },
      );
    }
  }
}

// circular progress bar while waiting for AppUser to start streaming
// once complete -> navigate to routes page.
class UserDataWrapper extends StatelessWidget {
  const UserDataWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);
    if (appUser == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Linear progress indicator',
          ),
        ),
      );
    } else {
      return const RouterScreen();
    }
  }
}
