import 'package:flutter/material.dart';

// A stateless widget that represents a styled TextField specifically for entering an email address.
class TextFieldEmail extends StatelessWidget {
  // Constructor for the TextFieldEmail widget.
  // It requires a TextEditingController to manage the input value of the TextField.
  const TextFieldEmail({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController =
            emailController, // Initializing the private _emailController variable with the provided emailController.
        super(key: key); // Calling the parent constructor (superclass).

  // Private variable to store the TextEditingController, which manages the input value of the TextField.
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    // Returning a styled TextField widget.
    return TextField(
      controller: _emailController, // Assigning the controller.
      style: const TextStyle(
          color: Colors.white), // Setting the text color to white.
      decoration: const InputDecoration(
        labelStyle:
            TextStyle(color: Colors.white70), // Style for the floating label.
        floatingLabelStyle: TextStyle(
            color: Colors
                .white70), // Style when the label is floating above the TextField.
        border:
            OutlineInputBorder(), // Setting the border style of the TextField.
        enabledBorder: OutlineInputBorder(
          // Border style when the TextField is enabled.
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          // Border style when the TextField is in focus.
          borderSide: BorderSide(color: Colors.white70),
        ),
        labelText:
            'Email', // Label text that appears above the TextField when it's in focus or has content.
        prefixIcon: Icon(
          // Icon displayed at the beginning of the TextField.
          Icons.email,
          color: Colors.white70,
        ),
      ),
    );
  }
}
