// Import statements.
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:flutter_template/widgets/core/app_bar_title.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';

// Screen2 widget is a StatefulWidget.
class Screen2 extends StatefulWidget {
  // Constructor for the Screen2 widget.
  const Screen2({Key? key}) : super(key: key);

  // Creating the state for Screen2.
  @override
  _UserScreen2State createState() => _UserScreen2State();
}

class _UserScreen2State extends State<Screen2> {
  // initState() method. Currently, it's just calling the parent's initState.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Using Provider to get the user data from the AppUser model.
    final appUser = Provider.of<AppUser>(context);
    final theme = Provider.of<AppTheme>(context);

    // The main scaffold of the Screen2.
    return Scaffold(
      // Using a custom color for the background.
      backgroundColor: theme.currentTheme.colorScheme.background,

      // App bar with a custom title and background color.
      appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.currentTheme.colorScheme.primary,
          title: AppBarTitle(title: 'Screen 2')),

      // Main content of the Screen2.
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            // Displaying the user's unique ID.
            children: [
              // Empty Row widget - possibly a placeholder for future use.
              const Row(),
              Text(appUser.uid),
            ],
          ),
        ),
      ),
    );
  }
}
