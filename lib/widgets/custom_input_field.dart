// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:provider/provider.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String label;
  final IconData prefixIcon;
  final ValueChanged<String>? onChanged;
  final bool multiline; // <-- Add this
  final int maxLines; // <-- Add this

  const CustomInputField({
    Key? key,
    this.controller,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    this.onChanged,
    this.multiline = false, // <-- Set default value
    this.maxLines = 1, // <-- Set default value
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      maxLines: widget.multiline ? widget.maxLines : 1, // <-- Use it here
      keyboardType:
          widget.multiline ? TextInputType.multiline : TextInputType.text,
      style: TextStyle(
        color: theme.currentTheme.colorScheme.onPrimaryContainer,
        fontSize: 16.0,
      ),
      obscureText: widget.isPassword ? !_visibility : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: theme.currentTheme.colorScheme.onPrimaryContainer),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: theme.currentTheme.colorScheme.onPrimaryContainer),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: theme.currentTheme.colorScheme.onPrimaryContainer,
              width: 2.0),
        ),
        labelStyle: theme.currentTheme.textTheme.headlineMedium,
        labelText: widget.label,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: theme.currentTheme.colorScheme.primary,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _visibility = !_visibility;
                  });
                },
                icon: Icon(
                  _visibility ? Icons.visibility_off : Icons.visibility,
                  color: theme.currentTheme.colorScheme.primary,
                ),
              )
            : null,
      ),
    );
  }
}
