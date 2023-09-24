import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/res/app_theme.dart'; // Assuming the AppTheme class is in this directory.

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);

    return TextField(
      controller: _emailController,
      style: theme.currentTheme.textTheme.headlineMedium,
      decoration: InputDecoration(
        labelStyle: theme.currentTheme.textTheme.headlineMedium,
        floatingLabelStyle: theme.currentTheme.textTheme.headlineMedium,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        focusColor: theme.currentTheme.colorScheme.primary,
        labelText: 'Email',
        prefixIcon: const Icon(
          Icons.email,
        ),
      ),
    );
  }
}
