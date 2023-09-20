// Required Flutter packages
import 'package:flutter/material.dart';

// Internal imports for functionalities and utilities
import 'package:flutter_template/utils/authentication.dart';
import '../../res/custom_colors.dart';
import '../../utils/show_message_helper.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/custom_button.dart';

// This widget represents the Reset Password screen.
class ResetPassword extends StatelessWidget {
  // Constructor with an optional key.
  const ResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller for capturing email input.
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      // AppBar design and properties
      appBar: AppBar(
        elevation: 0, // No shadow beneath the app bar
        backgroundColor: CustomColors.firebaseNavy, // AppBar background color
        title: AppBarTitle(title: 'Resert Password'), // AppBar title widget
      ),
      body: Container(
        decoration: BoxDecoration(
          color: CustomColors.firebaseNavy, // Body background color
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the column vertically
            children: [
              // Text header prompting user to reset their password.
              const Text(
                'Receive an email to\nreset your password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              // Spacing widget
              const SizedBox(height: 36.0),
              // Email input field.
              TextField(controller: emailController),
              // Spacing widget
              const SizedBox(height: 18.0),
              // Custom button to trigger the password reset action.
              CustomButton(
                text: 'Reset Password',
                onPressed: () {
                  // Check if email is empty or invalid.
                  if (emailController.text.isEmpty) {
                    ShowMessageHelper.showMessage(
                        context: context, text: 'Enter a valide email');
                    return;
                  } else if (!emailController.text.contains('@')) {
                    ShowMessageHelper.showMessage(
                        context: context, text: 'Enter a valide email');
                    return;
                  }
                  // Call the authentication service to reset the password.
                  AuthService().resetPassword(
                    email: emailController.text,
                  );
                  // Return to the previous screen.
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
