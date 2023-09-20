// Required for ignoring specific lint warnings in the file
// ignore_for_file: use_key_in_widget_constructors

// Import for initializing Firebase core.
import 'package:firebase_core/firebase_core.dart';

// Flutter's material design-based widget library.
import 'package:flutter/material.dart';

// Service handling authentication functionalities.
import 'package:flutter_template/utils/authentication.dart';

// Wrapper widget to decide which screen to show based on authentication status.
import 'package:flutter_template/wrapper.dart';

// Model representing a user's authentication data.
import 'models/userModel.dart';

// Package for state management and dependency injection.
import 'package:provider/provider.dart';

// Main function - Entry point for the Flutter app.
void main() async {
  // Ensures widget-binding is initialized.
  // Required for any interaction with the Flutter framework, e.g., plugin use.
  WidgetsFlutterBinding.ensureInitialized();

  // Asynchronous initialization of Firebase.
  await Firebase.initializeApp();

  // runApp makes the given widget the root of the widget tree and initializes the app.
  runApp(MyApp());
}

// Root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // List of providers for state management.
        providers: [
          // StreamProvider listens to changes in the authentication state and
          // provides them down the widget tree.
          // AuthUser object will be streamed for any authentication state changes.
          StreamProvider<AuthUser?>.value(
              initialData: null, value: AuthService().onAuthStateChanged),
        ],
        builder: (context, snapshot) {
          // MaterialApp is a widget that introduces many material design widgets into the app.
          return MaterialApp(
            // Starting widget for the app, which decides which screen to show based on the user's authentication status.
            home: AuthWrapper(),
          );
        });
  }
}
