// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_template/res/custom_colors.dart';
import 'package:provider/provider.dart';

import '../models/userModel.dart';
import '../widgets/app_bar_title.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _UserScreen2State createState() => _UserScreen2State();
}

class _UserScreen2State extends State<Screen2> {
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
          title: AppBarTitle(title: 'Screen 2')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Row(), Text(appUser.uid)],
          ),
        ),
      ),
      //  bottomNavigationBar: BottomNavBar(),
    );
  }
}
