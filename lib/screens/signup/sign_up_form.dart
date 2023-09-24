// Flutter and Firebase package imports.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/res/app_theme.dart';

// Relative imports.
import 'package:flutter_template/screens/login/login_screen.dart';
import '../../utils/authentication.dart';
import '../../widgets/show_message_helper.dart';
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

  bool _visibility = true;
  bool _visibilityConf = true;

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
        const Text(
          'Register',
          style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'Please register account for access.',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 80.0),
        // Email input field
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            labelText: 'Email',
            prefixIcon: Icon(
              Icons.email,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: _passwordController,
          obscureText: _visibility,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
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
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: _passwordConfirmController,
          obscureText: _visibilityConf,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
            labelText: 'Confirm password',
            prefixIcon: const Icon(
              Icons.password,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                _visibilityConf = !_visibilityConf;
              }),
              icon: Icon(
                _visibility ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: theme.currentTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  )),
            )
          ],
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
                text: const TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(fontSize: 16.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
