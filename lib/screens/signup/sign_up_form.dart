// Flutter and Firebase package imports.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/core/custom_button.dart';
import 'package:flutter_template/widgets/core/custom_input_field.dart';
import 'package:flutter_template/widgets/core/show_message_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/res/app_theme.dart';

// Relative imports.
import 'package:flutter_template/screens/login/login_screen.dart';
import '../../utils/authentication.dart';
import '../../wrapper.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) => email.isNotEmpty && email.contains('@');

  bool _isValidPassword(String password) =>
      password.isNotEmpty && password.length >= 8;

  Future<void> _signUp() async {
    if (!_isValidEmail(_emailController.text)) {
      ShowMessageHelper.showMessage(context: context, text: 'Check Email');
      return;
    } else if (!_isValidPassword(_passwordController.text)) {
      ShowMessageHelper.showMessage(
          context: context,
          text: 'Check password, password must be greater than 8');
      return;
    } else if (_passwordController.text != _passwordConfirmController.text) {
      ShowMessageHelper.showMessage(
          context: context,
          text: 'Check password, password does not match confirmed');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      AuthService().createUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => AuthWrapper()), (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowMessageHelper.showMessage(
            context: context, text: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ShowMessageHelper.showMessage(
            context: context, text: 'email-already-in-use');
      }
    } catch (e) {
      ShowMessageHelper.showMessage(context: context, text: 'Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Registration header
        Text(
          'Register',
          style: theme.currentTheme.textTheme.displayMedium,
        ),
        const SizedBox(height: 18.0),
        Text('Please register account for access.',
            style: theme.currentTheme.textTheme.displayMedium),
        const SizedBox(height: 80.0),
        // Email input field
        CustomInpuField(
          controller: _emailController,
          label: 'Email',
          prefixIcon: Icons.email,
        ),
        const SizedBox(height: 8.0),
        CustomInpuField(
          controller: _passwordController,
          label: 'Password',
          prefixIcon: Icons.email,
          isPassword: true,
        ),
        const SizedBox(height: 8.0),
        CustomInpuField(
          controller: _passwordConfirmController,
          label: 'Confirm Password',
          prefixIcon: Icons.email,
          isPassword: true,
        ),
        const SizedBox(height: 18.0),
        CustomButton(
          onPressed: _signUp,
          label: 'Sign Up',
          icon: Icons.app_registration, // Your choice of icon
        ),
        const SizedBox(height: 18.0),
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(fontSize: 16.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme
                                .currentTheme.colorScheme.onPrimaryContainer)),
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
