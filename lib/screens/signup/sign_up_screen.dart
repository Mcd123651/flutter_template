// Required Flutter package
import 'package:flutter/material.dart';

// Internal imports for custom colors and form components
import 'package:flutter_template/res/custom_colors.dart';
import 'package:flutter_template/screens/signup/sign_up_form.dart';

// This widget represents the main sign-up screen.
class SignUpScreen extends StatelessWidget {
  // A constant identifier for this screen, useful for navigation
  static const String id = 'signUp';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This ensures that the keyboard does not resize the screen contents
      resizeToAvoidBottomInset: false,
      body: Container(
        // Setting the background color for this screen
        decoration: BoxDecoration(
          color: CustomColors.firebaseNavy,
        ),
        child: const Stack(
          children: [
            // Positioned widget to place an icon on the screen in a specific location
            Positioned(
                right: 40.0,
                top: 95.0,
                child: Icon(
                  Icons.lock_outline, // Icon representing a lock
                  color: Colors.white12, // Icon color with reduced opacity
                  size: 60.0, // Size of the icon
                )),
            // Padding widget to give some space from the screen edges
            Padding(
              // Horizontal padding
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              // SignUpForm widget which contains the fields and button for user registration
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}
