import 'package:flutter/material.dart';
import 'package:flutter_template/res/custom_colors.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: CustomColors.firebaseNavy,
        ),
        child: Stack(
          children: [
            const Positioned(
                right: 40.0,
                top: 50.0,
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.white12,
                  size: 60.0,
                )),
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
