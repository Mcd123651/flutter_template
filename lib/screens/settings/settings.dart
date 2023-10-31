// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_template/models/userModel.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:flutter_template/services/authentication.dart';
import 'package:flutter_template/services/providers/user_notifier.dart';
import 'package:flutter_template/widgets/custom_button.dart';
import 'package:flutter_template/wrapper.dart';
import 'package:provider/provider.dart';
import 'display_info_tile.dart';
import 'toggle_switch_tile.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final theme = Provider.of<AppTheme>(context);
    AppUser appUser = userNotifier.appUser as AppUser;

    return Scaffold(
      backgroundColor: theme.currentTheme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.currentTheme.colorScheme.primary,
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              DisplayInfoTile(title: 'Display Name', data: appUser.displayName),
              DisplayInfoTile(title: 'Email', data: appUser.email),
              ToggleSwitchTile(
                title: 'Dark Mode',
                value: theme.isDarkTheme,
                onChanged: (value) {
                  theme.toggleTheme();
                },
              ),
              const SizedBox(height: 24.0),
              // Sign Out Button
              Center(
                child: CustomButton(
                  label: 'Sign Out',
                  onPressed: () async {
                    await AuthService.signOut(context: context);

                    // Navigate to the AuthWrapper after signing out
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const AuthWrapper()),
                        (Route<dynamic> route) =>
                            false // This will remove all previous routes and make the AuthWrapper the root.
                        );
                  },
                  icon: Icons.time_to_leave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
