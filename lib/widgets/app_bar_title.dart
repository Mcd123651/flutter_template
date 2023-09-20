// Ignoring certain linting rules for this file
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

// Required Flutter package for material design widgets
import 'package:flutter/material.dart';
// Importing custom color resources
import 'package:flutter_template/res/custom_colors.dart';

// This widget is designed to represent the title within an AppBar.
class AppBarTitle extends StatelessWidget {
  // Constructor to create an instance of AppBarTitle.
  // This requires a 'title' to be passed when instantiated.
  AppBarTitle({Key? key, required this.title}) : super(key: key);

  // This string holds the title for the AppBar
  late String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Aligning children to the start vertically
      mainAxisSize:
          MainAxisSize.min, // Using minimum space as required by the children
      children: [
        Text(
          title, // Setting the title text
          style: TextStyle(
            color: CustomColors
                .firebaseYellow, // Using a custom yellow color for the title
            fontSize: 18, // Setting font size
          ),
        ),
      ],
    );
  }
}
