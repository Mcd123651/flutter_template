// display_info_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:provider/provider.dart';

class DisplayInfoTile extends StatelessWidget {
  final String title;
  final String? data;

  const DisplayInfoTile({super.key, required this.title, this.data});

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
      subtitle: Text(
        data ?? 'N/A',
        style: TextStyle(
          fontSize: 18.0,
          color: theme.currentTheme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
