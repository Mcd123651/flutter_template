import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:flutter_template/services/authentication.dart';
import 'package:flutter_template/services/providers/user_notifier.dart';
import 'package:flutter_template/wrapper.dart';
import 'models/userModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Load the user's preferred theme from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool initialDarkTheme = prefs.getBool('isDarkTheme') ?? false;

  runApp(MyApp(initialDarkTheme: initialDarkTheme));
}

class MyApp extends StatelessWidget {
  final bool initialDarkTheme;

  const MyApp({required this.initialDarkTheme, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MultiProvider used to wrap the entire app with the necessary providers
    return MultiProvider(
      providers: [
        // StreamProvider for user authentication status
        StreamProvider<AuthUser?>.value(
          initialData: null,
          value: AuthService().onAuthStateChanged,
        ),
        // Providers for app theme, user data, bots data, and chat data
        ChangeNotifierProvider<UserNotifier>(
          create: (context) => UserNotifier(),
        ),
        ChangeNotifierProvider<AppTheme>(
          create: (context) => AppTheme(initialDarkTheme),
        ),
      ],
      child: const MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}
