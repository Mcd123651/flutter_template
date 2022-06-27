// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/screens/home_screen.dart';
import 'package:flutter_template/screens/screen_2.dart';
import 'package:flutter_template/screens/user_info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late User _user;
  int _selectedIndex = 0;

  var _pageRoutes;
  @override
  void initState() {
    super.initState();
    _user = widget._user;
    _pageRoutes = [
      HomePage(user: _user),
      Screen2(user: _user),
      UserInfoScreen(user: _user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: 'fact_check',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'manage_accounts',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _pageRoutes.elementAt(_selectedIndex),
    );
  }
}
