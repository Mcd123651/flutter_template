import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/resources/app_theme.dart';
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
