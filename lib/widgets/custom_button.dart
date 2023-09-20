// Required Flutter package for material design widgets.
import 'package:flutter/material.dart';

// Importing custom color resources.
import '../res/custom_colors.dart';

// This widget provides a customizable button with a specific style.
class CustomButton extends StatelessWidget {
  // Constructor to create an instance of CustomButton.
  // 'text' and 'onPressed' are required arguments.
  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  // This string holds the text that will be displayed on the button.
  final String text;
  // The function that will be executed when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Using the 'Expanded' widget to ensure the button takes the full width available within its parent.
        Expanded(
          child: ElevatedButton(
              onPressed: onPressed, // Setting the press behavior of the button.
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets
                    .zero, // Removing any default padding from the button.
                // Setting the button's shape to be a rounded rectangle with rounded edges.
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              child: Ink(
                // Applying a custom decoration to the button.
                decoration: BoxDecoration(
                    color: CustomColors
                        .firebaseOrange, // Setting the button's color.
                    borderRadius: BorderRadius.circular(
                        12.0)), // Applying rounded edges to the decoration.
                child: Container(
                  height: 50.0, // Setting a fixed height for the button.
                  alignment:
                      Alignment.center, // Centering the text within the button.
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0), // Adding padding to the text.
                    child: Text(
                      text, // Displaying the text on the button.
                      style: const TextStyle(
                          fontSize: 18.0), // Setting the text's style.
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
