import 'package:flutter/material.dart';
import 'package:flutter_template/models/userModel.dart';
import 'package:flutter_template/screens/home/home_screen.dart';
import 'package:flutter_template/screens/screen2/screen_2.dart';
import 'package:flutter_template/screens/settings/settings.dart';
import 'package:flutter_template/widgets/custom_navigation_bar.dart';

/// RouterScreen widget: Acts as the main routing hub for navigating between
/// different app screens using the CustomNavigationBar.
class RouterScreen extends StatefulWidget {
  final AppUser appUser;

  const RouterScreen({Key? key, required this.appUser}) : super(key: key);

  @override
  RouterScreenState createState() => RouterScreenState();
}

class RouterScreenState extends State<RouterScreen> {
  int _selectedIndex = 0;

  // List of app screens corresponding to the CustomNavigationBar items.
  final List<Widget> _pageRoutes = [
    const HomePage(),
    const Screen2(),
    const UserInfoScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) => setState(
            () => _selectedIndex = index), // Inline function for brevity.
      ),
      body: _pageRoutes[
          _selectedIndex], // Directly access the list using the index.
    );
  }
}
