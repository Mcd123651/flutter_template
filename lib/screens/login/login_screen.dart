import 'package:flutter/material.dart';
import 'package:flutter_template/res/custom_colors.dart'; // Custom colors used in the app.
import 'login_form.dart'; // Import the LoginForm widget.

class LoginScreen extends StatelessWidget {
  // A static constant for screen identification, useful for routes.
  static const String id = 'login';

  // Constructor.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Avoids resizing the screen when keyboard appears.
      resizeToAvoidBottomInset: false,

      body: Container(
        // Setting the background color.
        decoration: BoxDecoration(
          color: CustomColors.firebaseNavy,
        ),

        child: Stack(
          children: [
            // An icon positioned at the top-right corner, acting as a decorative element.
            const Positioned(
                right: 40.0,
                top: 50.0,
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.white12,
                  size: 60.0,
                )),

            // The LoginForm widget is wrapped with Padding to give some space on the sides.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
