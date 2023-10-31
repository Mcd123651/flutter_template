import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/custom_button.dart';
import 'package:flutter_template/widgets/custom_input_field.dart';
import 'package:flutter_template/widgets/show_message_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:flutter_template/services/authentication.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.currentTheme.colorScheme.primary,
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // Default back arrow
            color: theme
                .currentTheme.colorScheme.onPrimary, // Your choice of color
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: theme.currentTheme.colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Receive an email to\nreset your password',
                style: TextStyle(
                    fontSize: 20.0,
                    color: theme.currentTheme.colorScheme.onPrimaryContainer),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36.0),
              const CustomInputField(
                label: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 18.0),
              CustomButton(
                label: 'Reset Password',
                onPressed: () {
                  if (emailController.text.isEmpty) {
                    ShowMessageHelper.showMessage(
                        context: context, text: 'Enter a valide email');
                    return;
                  } else if (!emailController.text.contains('@')) {
                    ShowMessageHelper.showMessage(
                        context: context, text: 'Enter a valide email');
                    return;
                  }
                  AuthService().resetPassword(
                    email: emailController.text,
                  );
                  Navigator.pop(context);
                },
                icon: Icons.lock,
              )
            ],
          ),
        ),
      ),
    );
  }
}
