// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

// Flutter package imports.
import 'package:flutter/material.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:flutter_template/screens/login/reset_password.dart';
import 'package:flutter_template/utils/authentication.dart';
import 'package:provider/provider.dart';

// Relative imports.
import '../../widgets/google_sign_in_button.dart';
import '../../widgets/textfield_email.dart';
import '../../wrapper.dart';
import '../signup/sign_up_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  bool _visibility = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWelcomeText(),
        _buildEmailInput(),
        _buildPasswordInput(),
        _buildLoginButton(),
        _buildGoogleSignInButton(),
        _buildForgotPasswordOption(),
        _buildSignUpOption(),
      ],
    );
  }

  Widget _buildWelcomeText() {
    final theme = Provider.of<AppTheme>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 100.0),
        Text(
          'Hello,',
          style: theme.currentTheme.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 18.0),
        Text(
          'This is a FireAuth flutter application template',
          style: theme.currentTheme.textTheme.headlineMedium,
        ),
        SizedBox(height: 50.0),
      ],
    );
  }

  Widget _buildEmailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldEmail(emailController: emailController),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildPasswordInput() {
    final theme = Provider.of<AppTheme>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: passwordController,
          obscureText: _visibility,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
            focusColor: theme.currentTheme.colorScheme.primary,
            labelText: 'Password',
            prefixIcon: const Icon(
              Icons.password,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                _visibility = !_visibility;
              }),
              icon: Icon(
                _visibility ? Icons.visibility_off : Icons.visibility,
                color: theme.currentTheme.colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }

  Widget _buildLoginButton() {
    final theme = Provider.of<AppTheme>(context);
    return Row(
      children: [
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
                    color: theme.currentTheme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: theme.currentTheme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GoogleSignInButton(),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordOption() {
    final theme = Provider.of<AppTheme>(context);
    return Padding(
      padding: EdgeInsets.only(top: 50),
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
            child: Text(
              'Forgot Password',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: theme.currentTheme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpOption() {
    final theme = Provider.of<AppTheme>(context);
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignUpScreen())),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'Don\'t have an account, yet? ',
              style: theme.currentTheme.textTheme.headlineMedium,
              children: <TextSpan>[
                TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.currentTheme.colorScheme.primary)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
