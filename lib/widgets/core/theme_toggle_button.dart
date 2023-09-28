import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/res/app_theme.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);

    return IconButton(
      icon: Icon(
        appTheme.isDarkTheme ? Icons.brightness_high : Icons.brightness_low,
      ),
      onPressed: () {
        appTheme.toggleTheme();
      },
    );
  }
}
