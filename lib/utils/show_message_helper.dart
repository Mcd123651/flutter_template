// Required Flutter package for material design widgets
import 'package:flutter/material.dart';

// This class provides a helper method to show messages (like error or success messages) on the screen.
class ShowMessageHelper {
  // Static method to show a message on the screen
  static showMessage(
      {required BuildContext
          context, // The context from where this method is called, used for displaying the SnackBar
      required String text, // The message to be displayed
      bool isError =
          true // Flag to determine if the message is an error or not, by default it's true (i.e., an error message)
      }) {
    // Using the ScaffoldMessenger to display the SnackBar on the screen
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text, // The message passed as a parameter
        style: const TextStyle(
          color: Colors.white, // Setting the text color to white
          fontSize: 18.0, // Font size of the message
        ),
      ),
      // Conditional background color: if it's an error message, the background will be red; otherwise, it will be green.
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }
}
