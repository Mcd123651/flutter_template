// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_template/models/userModel.dart';
import 'package:flutter_template/widgets/core/cusom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/screens/home_screen.dart';
import 'package:flutter_template/screens/screen_2.dart';
import 'package:flutter_template/screens/screen_3.dart';

class RouterScreen extends StatefulWidget {
  final AppUser appUser;

  const RouterScreen({Key? key, required this.appUser}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<RouterScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pageRoutes = [
    const HomePage(),
    const Screen2(),
    const UserInfoScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Provider<AppUser>.value(
      value: widget.appUser,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: _selectedIndex,
          onTabSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _pageRoutes.elementAt(_selectedIndex),
      ),
    );
  }
}
