// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../screens/sign_in_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SignInScreen();
  }
}
