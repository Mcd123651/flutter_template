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
      return FutureBuilder<AppUser?>(
        future: _dbService.createUserAndFetch(authUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ErrorScreen(error: snapshot.error.toString());
            }
            return StreamProvider<AppUser?>.value(
              initialData: null,
              value: _dbService.streamAppUser(authUser),
              child: const UserDataWrapper(),
            );
          } else {
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

// ErrorScreen widget to display errors
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
                Navigator.of(context).pop(); // Pop the current screen
              },
              child: const Text("Try Again"),
            )
          ],
        ),
      ),
    );
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
