// This line instructs the Dart linter to ignore any warnings related to the use
// of non-const constructors in the file. This can be useful when you're aware of
// the linting rule but have chosen not to follow it for specific reasons.
// ignore_for_file: prefer_const_constructors

// Import the Flutter Material Design library. This provides access to the Color
// class and many other UI-related functionalities.
import 'package:flutter/material.dart';

// Define a CustomColors class to act as a collection or palette of predefined
// custom color constants. This centralizes and standardizes the color definitions
// used throughout the application.
class CustomColors {
  // Define a static constant for a navy blue color.
  // The 'static' keyword means that the variable belongs to the class itself
  // and not to instances of the class. 'final' means its value is set once and
  // cannot be changed.
  static final Color firebaseNavy = Color(0xFF2C384A);

  // Define a static constant for an orange color.
  static final Color firebaseOrange = Color(0xFFF57C00);

  // Define a static constant for an amber color.
  static final Color firebaseAmber = Color(0xFFFFA000);

  // Define a static constant for a yellow color.
  static final Color firebaseYellow = Color(0xFFFFCA28);

  // Define a static constant for a light grey color.
  static final Color firebaseGrey = Color(0xFFECEFF1);

  // Define a static constant for a blue color,
  // often associated with Google's branding.
  static final Color googleBackground = Color(0xFF4285F4);
}
