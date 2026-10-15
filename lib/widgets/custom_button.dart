import 'package:flutter/material.dart';

// CUSTOM WIDGET: rounded button with optional icon and loading spinner.
// The shape comes from filledButtonTheme in main.dart (Theme).
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // While loading, disable the button and show a spinner.
    final VoidCallback? action = isLoading ? null : onPressed;
    if (isLoading) {
      return FilledButton(
        onPressed: action,
        child: const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
    }
    if (icon == null) {
      return FilledButton(onPressed: action, child: Text(label));
    }
    return FilledButton.icon(
      onPressed: action,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
