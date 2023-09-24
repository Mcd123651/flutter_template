// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    final theme = Provider.of<AppTheme>(context);

    return Scaffold(
      backgroundColor: theme.currentTheme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.currentTheme.colorScheme.primary,
        title: Text(
          'Home Screen',
          style: TextStyle(
            fontSize: 18.0,
            color: theme.currentTheme.colorScheme.onPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              Text(appUser.uid),
              Text(appUser.email ?? ''),
              Text(appUser.displayName ?? ''),
              if (appUser.photoURL != null)
                _userImage(appUser.photoURL!)
              else
                _defaultUserIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userImage(String url) {
    final theme = Provider.of<AppTheme>(context);
    return ClipOval(
      child: Material(
        color: theme.currentTheme.colorScheme.onPrimary,
        child: Image.network(url, fit: BoxFit.fitHeight),
      ),
    );
  }

  Widget _defaultUserIcon() {
    final theme = Provider.of<AppTheme>(context);
    return ClipOval(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            Icons.person,
            size: 60,
            color: theme.currentTheme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
