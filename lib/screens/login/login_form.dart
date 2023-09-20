// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_template/screens/login/reset_password.dart';
import 'package:flutter_template/utils/authentication.dart';
import '../../res/custom_colors.dart';
import '../../widgets/google_sign_in_button.dart';
import '../../widgets/textfield_email.dart';
import '../../wrapper.dart';
import '../signup/sign_up_screen.dart';

/// LoginForm widget that represents the user interface for logging in.
class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    // Controllers for the email and password input fields.
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome text.
        const SizedBox(height: 100.0),
        const Text(
          'Hello,',
          style: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'This is a FireAuth flutter application template',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 50.0),

        // Email input widget.
        TextFieldEmail(emailController: emailController),
        const SizedBox(height: 8.0),
        // Password input field with an option to toggle visibility.
        TextField(
          controller: passwordController,
          obscureText: _visibility,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            // ... (styles and icons for password field)
            labelStyle: const TextStyle(color: Colors.white70),
            floatingLabelStyle: const TextStyle(color: Colors.white70),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            labelText: 'Password',
            prefixIcon: const Icon(
              Icons.password,
              color: Colors.white70,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                _visibility = !_visibility;
              }),
              icon: Icon(
                _visibility ? Icons.visibility_off : Icons.visibility,
                color: Colors.white70,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        // Login button which triggers the login process.
        Row(
          children: [
            // ... (ElevatedButton with styling and onPressed logic)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    AuthService().signInWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => AuthWrapper()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: CustomColors.firebaseOrange,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        // Google Sign-In button.
        Padding(
          // ... (GoogleSignInButton with padding)
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GoogleSignInButton(),
              ]),
        ),
        // Option to navigate to reset password page.
        Padding(
          // ... (GestureDetector for 'Forgot Password' with padding)
          padding: EdgeInsets.only(
            top: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPassword()));
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
        // Option to navigate to the sign-up page.
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpScreen())),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Don\'t have an account, yet? ',
                  style: TextStyle(color: Colors.white70, fontSize: 16.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
