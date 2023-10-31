import 'package:flutter/material.dart';
import 'package:flutter_template/resources/app_theme.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  color: theme.currentTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(icon,
                              color: theme.currentTheme.colorScheme.onPrimary),
                          const SizedBox(
                              width:
                                  5.0), // A little space between icon and label
                        ],
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: theme.currentTheme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
