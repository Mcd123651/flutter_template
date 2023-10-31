import 'package:flutter/material.dart';
import 'package:flutter_template/models/userModel.dart';
import 'package:flutter_template/router.dart';
import 'package:flutter_template/screens/login/login_screen.dart';
import 'package:flutter_template/services/providers/user_notifier.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  AuthWrapperState createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  Future<void>? fetchOrCreateUserFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authUser = Provider.of<AuthUser?>(context);

    if (authUser != null && fetchOrCreateUserFuture == null) {
      fetchOrCreateUserFuture =
          Provider.of<UserNotifier>(context, listen: false)
              .fetchOrCreateUser(authUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthUser?>(context);

    if (authUser == null) {
      return const LoginScreen();
    }

    return FutureBuilder(
      future: fetchOrCreateUserFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return ErrorScreen(error: snapshot.error.toString());
          }

          final appUser = Provider.of<UserNotifier>(context).appUser;

          if (appUser == null) return _loadingScreen();

          return RouterScreen(appUser: appUser);
        }
        return _loadingScreen();
      },
    );
  }

  Widget _loadingScreen() => const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
}

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({required this.error, Key? key}) : super(key: key);

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
            const Text("Oops! An error occurred.",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(error),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Try Again"))
          ],
        ),
      ),
    );
  }
}

class UserDataWrapper extends StatelessWidget {
  const UserDataWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);

    if (appUser == null) return _loadingScreen();
    return RouterScreen(appUser: appUser);
  }

  Widget _loadingScreen() => const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: CircularProgressIndicator(
                semanticsLabel: 'Linear progress indicator')),
      );
}
