import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
            width: 50, height: 50, child: CircularProgressIndicator()));
  }
}

class ErrorIndicator extends StatelessWidget {
  final String errorMessage;

  const ErrorIndicator(this.errorMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('An error occurred: $errorMessage'));
  }
}

class EmptyIndicator extends StatelessWidget {
  final String message;

  // Making the default message 'No bots found' if nothing is passed
  const EmptyIndicator({this.message = 'No items found', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
