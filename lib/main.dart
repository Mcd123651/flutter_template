import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:flutter_template/utils/authentication.dart';
import 'package:flutter_template/wrapper.dart';
import 'models/userModel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<AuthUser?>.value(
            initialData: null,
            value: AuthService().onAuthStateChanged,
          ),
          ChangeNotifierProvider<AppTheme>(
            // <-- Add this provider
            create: (context) => AppTheme(),
          ),
        ],
        builder: (context, snapshot) {
          return MaterialApp(
            // launch wrapper.dart
            home: AuthWrapper(),
          );
        });
  }
}
