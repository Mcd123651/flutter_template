// toggle_switch_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:provider/provider.dart';

class ToggleSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const ToggleSwitchTile(
      {super.key,
      required this.title,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: theme.currentTheme.colorScheme.primary,
        ),
      ),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}
