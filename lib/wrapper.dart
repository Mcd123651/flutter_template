// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_template/screens/login/login_screen.dart';
import 'package:flutter_template/utils/db.dart';
import 'package:flutter_template/router.dart';
import 'package:provider/provider.dart';
import 'models/userModel.dart';

/// AuthWrapper widget: The main responsibility of this widget is to check the
/// authentication state of the user.
/// - If the user is not authenticated, navigate to the LoginScreen.
/// - If the user is authenticated, use the FutureBuilder to create the user in the database (if not exists)
///   and then stream user details using UserDataWrapper.
class AuthWrapper extends StatelessWidget {
  AuthWrapper({Key? key}) : super(key: key);

  // Single instance of the DatabaseService to perform DB operations
  final _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    // Fetch the current authentication state using the Provider
    final authUser = Provider.of<AuthUser?>(context);
    print('AuthUser is: ${authUser != null ? 'present' : 'null'}');

    // If the user is not authenticated, display the login screen.
    if (authUser == null) {
      return const LoginScreen();
    } else {
      // If the user is authenticated, use FutureBuilder to perform async operations
      // and handle different states (like loading, error, or data received).
      return FutureBuilder<AppUser?>(
        future: _dbService.createUserAndFetch(authUser),
        builder: (context, snapshot) {
          print('Database fetch connection state: ${snapshot.connectionState}');

          // If the future operation is complete
          if (snapshot.connectionState == ConnectionState.done) {
            // If there's an error, display the error screen
            if (snapshot.hasError) {
              return ErrorScreen(error: snapshot.error.toString());
            }
            // If everything is fine, stream the user details using StreamProvider
            // and wrap it with UserDataWrapper.
            return StreamProvider<AppUser?>.value(
              initialData: null,
              value: _dbService.streamAppUser(authUser),
              child: const UserDataWrapper(),
            );
          } else {
            // Display a loading indicator while the future operation is in progress.
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            );
          }
        },
      );
    }
  }
}

/// ErrorScreen widget: This widget is used to display an error message to the user.
/// It also provides an option to "Try Again".
class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error Occurred")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.error_outline, color: Colors.red, size: 60.0),
            const SizedBox(height: 20),
            const Text(
              "Oops! An error occurred.",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(error),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Pop the current screen to potentially try the operation again or go back.
                Navigator.of(context).pop();
              },
              child: const Text("Try Again"),
            )
          ],
        ),
      ),
    );
  }
}

/// UserDataWrapper widget: This widget's role is to listen to the AppUser stream.
/// - If the data is not yet available, it shows a loading indicator.
/// - Once the data is available, it navigates to the main RouterScreen.
class UserDataWrapper extends StatelessWidget {
  const UserDataWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen to the AppUser stream using Provider
    final appUser = Provider.of<AppUser?>(context);

    // If the AppUser data is not yet available, show a loading indicator.
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
      // If the AppUser data is available, navigate to the main RouterScreen.
      return const RouterScreen();
    }
  }
}
