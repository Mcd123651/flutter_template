// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/res/custom_colors.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';
import '../widgets/app_bar_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(title: 'Home Screen'),
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
    return ClipOval(
      child: Material(
        color: CustomColors.firebaseGrey.withOpacity(0.3),
        child: Image.network(url, fit: BoxFit.fitHeight),
      ),
    );
  }

  Widget _defaultUserIcon() {
    return ClipOval(
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
    );
  }
}
