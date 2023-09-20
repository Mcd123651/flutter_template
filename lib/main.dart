// ignore_for_file: use_key_in_widget_constructors
// https://stackoverflow.com/questions/61930007/how-to-solve-execution-failed-for-task-appcompileflutterbuilddebug
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/authentication.dart';
import 'package:flutter_template/wrapper.dart';
import 'models/userModel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // stream auth user while check for auth stage changes
          StreamProvider<AuthUser?>.value(
              initialData: null, value: AuthService().onAuthStateChanged),
        ],
        builder: (context, snapshot) {
          return MaterialApp(
            home: Wrapper(),
          );
        });
  }
}
