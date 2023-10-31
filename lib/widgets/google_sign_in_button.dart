// Directives to tell the analyzer to ignore specific lint warnings for this file.
// These can be useful for suppressing certain warnings that the developer deemed unnecessary for this file.
// Note: It's advisable to address the warnings rather than suppress them unless there's a specific reason to do so.
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_template/services/authentication.dart';
import 'package:flutter_template/wrapper.dart';

// Importing the AuthWrapper, which seems to serve as a root widget that determines if the user is authenticated.

// A stateful widget that represents a button for Google Sign-In.
class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

// The state class for GoogleSignInButton.
class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16.0), // Adding padding at the bottom.
      child: OutlinedButton(
        // Button styling.
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(40), // Giving the button rounded edges.
            ),
          ),
        ),
        // Defining what happens when the button is pressed.
        onPressed: () async {
          // Sign in with Google and wait until the sign-in process is completed.
          await AuthService.signInWithGoogle(context: context);

          // If successful, navigate to the AuthWrapper widget and remove all previous routes.
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => AuthWrapper()),
              (route) => false);
        },
        child: Padding(
          // Adding padding to the button's content.
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                MainAxisAlignment.center, // Centering the content.
            children: <Widget>[
              // Displaying Google's logo.
              Image(
                image: AssetImage("assets/google_logo.png"),
                height: 35.0,
              ),
              // Adding some space between the logo and the text.
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google', // Text displayed on the button.
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight:
                        FontWeight.w600, // Making the text slightly bold.
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
