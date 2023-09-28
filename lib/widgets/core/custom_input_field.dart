// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:provider/provider.dart';

class CustomInpuField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String label;
  final IconData prefixIcon;

  const CustomInpuField({
    Key? key,
    this.controller,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _CustomInpuFieldState createState() => _CustomInpuFieldState();
}

class _CustomInpuFieldState extends State<CustomInpuField> {
  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return TextField(
      controller: widget.controller,
      style: TextStyle(
        color: theme.currentTheme.colorScheme
            .onPrimaryContainer, // For example, setting the text color to red
        fontSize: 16.0,
        // Add any other TextStyle properties you need
      ),
      obscureText: widget.isPassword ? _visibility : false,
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
