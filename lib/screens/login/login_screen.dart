// Package imports.
import 'package:flutter/material.dart';
import 'package:flutter_template/resources/app_theme.dart';

// Relative imports.
import 'package:provider/provider.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  // A static constant for screen identification, useful for routes.
  static const String id = 'login';

  // Constants for positioning and size.
  static const double iconRightPosition = 40.0;
  static const double iconTopPosition = 50.0;
  static const double iconSize = 60.0;
  static const EdgeInsets formPadding = EdgeInsets.symmetric(horizontal: 18.0);

  // Constructor.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Scaffold(
      // Avoids resizing the screen when keyboard appears.
      resizeToAvoidBottomInset: false,

      body: Container(
        decoration: BoxDecoration(
          color: theme.currentTheme.colorScheme.background,
        ),
        child: Stack(
          children: [
            Padding(
              padding: formPadding,
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
