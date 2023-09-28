import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/res/app_theme.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomNavigationBar(
      {super.key, required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);

    Color primaryColor = theme.currentTheme.colorScheme.primary;
    Color onPrimaryColor = theme.currentTheme.colorScheme.onPrimary;

    return BottomNavigationBar(
      elevation: 10.0,
      backgroundColor: primaryColor,
      currentIndex: selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: 'Facts'),
        BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts), label: 'Account'),
      ],
      onTap: onTabSelected,
      selectedItemColor: onPrimaryColor,
      unselectedItemColor: onPrimaryColor.withOpacity(0.6),
      selectedIconTheme: IconThemeData(
        size: 28,
        color: onPrimaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24,
        color: onPrimaryColor.withOpacity(0.6),
      ),
      selectedFontSize: 16,
      unselectedFontSize: 14,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
