// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_template/models/userModel.dart';
import 'package:flutter_template/res/custom_colors.dart';
import 'package:flutter_template/utils/authentication.dart';
import 'package:flutter_template/widgets/app_bar_title.dart';
import 'package:provider/provider.dart';
//import 'package:acehole/widgets/bottom_nav.dart';

// UserInfoScreen is a StatefulWidget.
class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Using Provider to fetch the user data from the AppUser model.
    final appUser = Provider.of<AppUser>(context);

    // The main scaffold of the UserInfoScreen.
    return Scaffold(
      // Setting background color.
      backgroundColor: CustomColors.firebaseNavy,

      // AppBar with title 'Profile'.
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(title: 'Profile'),
      ),

      // Main content of the UserInfoScreen.
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            // List of widgets displayed on the screen.
            children: [
              // Two empty Row widgets, possibly placeholders for future content.
              Row(),
              Row(),

              // Displaying the user's profile photo or a placeholder icon if the photo URL is null.
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
              SizedBox(height: 16.0),
              // Greeting text 'Hello' and the user's display name.
              Text(
                'Hello',
                style: TextStyle(
                  color: CustomColors.firebaseGrey,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                appUser.displayName!,
                style: TextStyle(
                  color: CustomColors.firebaseYellow,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              // Displaying the user's email.
              Text(
                '( ${appUser.email!} )',
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 24.0),
              // Information about signing out.
              Text(
                'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
                style: TextStyle(
                    color: CustomColors.firebaseGrey.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.redAccent,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Sign Out button which, when pressed, will call the signOut method from AuthService.
                onPressed: () async {
                  await AuthService.signOut(context: context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
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
