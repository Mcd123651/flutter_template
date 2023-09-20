// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_template/screens/home_screen.dart';
import 'package:flutter_template/screens/screen_2.dart';
import 'package:flutter_template/screens/screen_3.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<RouterScreen> {
  int _selectedIndex = 0;

  // Moved routes here instead of initState
  final List<Widget> _pageRoutes = [
    const HomePage(),
    const Screen2(),
    const UserInfoScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check), label: 'fact_check'),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts), label: 'manage_accounts'),
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
