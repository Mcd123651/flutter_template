// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/models/userModel.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:flutter_template/utils/authentication.dart';
import 'package:flutter_template/widgets/core/app_bar_title.dart';
import 'package:flutter_template/widgets/core/theme_toggle_button.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    final theme = Provider.of<AppTheme>(context);

    return Scaffold(
      backgroundColor: theme.currentTheme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.currentTheme.colorScheme.primary,
        title: AppBarTitle(title: 'Profile'),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appUser.photoURL != null
                  ? ClipOval(
                      child: Material(
                        color: theme.currentTheme.colorScheme.surface,
                        child: Image.network(
                          appUser.photoURL!,
                          fit: BoxFit.fitHeight,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: theme.currentTheme.colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: theme.currentTheme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 16.0),
              Text(
                'Hello',
                style: TextStyle(
                  color: theme.currentTheme.colorScheme.onBackground,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                appUser.displayName!,
                style: TextStyle(
                  color: theme.currentTheme.colorScheme.onBackground,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '( ${appUser.email!} )',
                style: TextStyle(
                  color: theme.currentTheme.colorScheme.onBackground,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
                style: TextStyle(
                  color: theme.currentTheme.colorScheme.onBackground,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      theme.currentTheme.colorScheme.onPrimaryContainer),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                ),
                onPressed: () async {
                  await AuthService.signOut(context: context);
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
