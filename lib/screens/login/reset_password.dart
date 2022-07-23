import 'package:flutter/material.dart';
import 'package:flutter_template/utils/authentication.dart';

import '../../res/custom_colors.dart';
import '../../utils/show_message_helper.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/custom_button.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(title: 'Resert Password'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: CustomColors.firebaseNavy,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Receive an email to\nreset your password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36.0),
              TextField(controller: emailController),
              const SizedBox(height: 18.0),
              CustomButton(
                  text: 'Reset Password',
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}
