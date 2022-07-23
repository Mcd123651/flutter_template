import 'package:flutter/material.dart';

class ShowMessageHelper {
  static showMessage(
      {required BuildContext context,
      required String text,
      bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }
}
