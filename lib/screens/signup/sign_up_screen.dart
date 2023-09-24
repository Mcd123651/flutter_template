import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:flutter_template/screens/signup/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'signUp';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: theme.currentTheme.colorScheme.background,
        ),
        child: const Stack(
          children: [
            Positioned(
              right: 40.0,
              top: 95.0,
              child: Icon(
                Icons.lock_outline,
                size: 60.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}
