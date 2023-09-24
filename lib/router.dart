// This directive tells the analyzer to ignore certain rules. You've ignored rules related
// to using private types in public API and untyped uninitialized variables.
// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_template/res/app_theme.dart';
import 'package:flutter_template/screens/home_screen.dart';
import 'package:flutter_template/screens/screen_2.dart';
import 'package:flutter_template/screens/screen_3.dart';
import 'package:provider/provider.dart';

/// RouterScreen widget: The primary role of this widget is to manage and display
/// different pages/screens based on the selected item from the bottom navigation bar.
class RouterScreen extends StatefulWidget {
  const RouterScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<RouterScreen> {
  // _selectedIndex keeps track of the currently selected item of the bottom navigation bar.
  int _selectedIndex = 0;

  // This list contains the actual widgets/screens associated with each item of the bottom navigation bar.
  // Moved the routes here for immediate initialization rather than within initState.
  final List<Widget> _pageRoutes = [
    const HomePage(),
    const Screen2(),
    const UserInfoScreen()
  ];

  // Not much happening in initState for now, but kept for potential future use.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Scaffold(
      // Common background color.
      backgroundColor: Colors.white,

      // BottomNavigationBar displays a row of items for navigation.
      // Tapping on an item updates _selectedIndex which in turn changes the displayed screen.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check), label: 'fact_check'),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts), label: 'manage_accounts'),
        ],
        // When an item is tapped, we update the _selectedIndex with the new index and trigger a rebuild.
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: theme.currentTheme.colorScheme
            .primary, // This line sets the selected item color to the theme's primary color.
      ),

      // Depending on the value of _selectedIndex, display the associated screen.
      body: _pageRoutes.elementAt(_selectedIndex),
    );
  }
}
