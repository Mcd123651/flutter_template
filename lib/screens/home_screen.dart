// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

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
  void initState() {
    super.initState();
  }

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
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(),
              Text(appUser.uid),
              Text(appUser.email ?? ''),
              Text(appUser.displayName ?? ''),
              //Text(appUser.lastSeen.toString()),
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
      //  bottomNavigationBar: BottomNavBar(),
    );
  }
}
