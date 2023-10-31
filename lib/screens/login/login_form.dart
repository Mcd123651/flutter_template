// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

// Flutter package imports.
import 'package:flutter/material.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:flutter_template/screens/login/reset_password.dart';
import 'package:flutter_template/services/authentication.dart';
import 'package:flutter_template/widgets/custom_button.dart';
import 'package:flutter_template/widgets/custom_input_field.dart';
import 'package:flutter_template/widgets/google_sign_in_button.dart';
import 'package:provider/provider.dart';

// Relative imports.
import '../../wrapper.dart';
import '../signup/sign_up_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
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
      children: const [
        CustomInputField(
          label: 'Email',
          prefixIcon: Icons.email,
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          controller: passwordController,
          label: 'Password',
          prefixIcon: Icons.password,
          isPassword: true,
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      onPressed: () {
        AuthService().signInWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => AuthWrapper()), (route) => false);
      },
      label: 'Login',
      icon: Icons.login, // Your choice of icon
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
