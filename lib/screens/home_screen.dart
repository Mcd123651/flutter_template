// Import statements.
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/res/custom_colors.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';
import '../widgets/app_bar_title.dart';

// HomePage widget is a StatefulWidget.
class HomePage extends StatefulWidget {
  // Constructor for the HomePage widget.
  const HomePage({Key? key}) : super(key: key);

  // Creating the state for HomePage.
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<HomePage> {
  // initState() method. Currently, it's just calling the parent's initState.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Using Provider to get the user data from the AppUser model.
    final appUser = Provider.of<AppUser>(context);

    // The main scaffold of the HomePage.
    return Scaffold(
      // Using a custom color for the background.
      backgroundColor: CustomColors.firebaseNavy,

      // App bar with a custom title and background color.
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(title: 'Home Screen'),
      ),

      // Main content of the HomePage.
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            // Displaying user-specific details.
            children: [
              // Empty Row widget - possibly a placeholder for future use.
              const Row(),
              Text(appUser.uid), // User ID
              Text(appUser.email ?? ''), // User email
              Text(appUser.displayName ?? ''), // User display name

              // Checking if user has a photo. If yes, it displays the photo, otherwise a default icon.
              appUser.photoURL != null
                  ? ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Image.network(
                          appUser.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: CustomColors.firebaseGrey,
                          ),
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
