import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

enum SnackBarType { info, success, warning, error }

void showAppSnackBar(
  BuildContext context,
  String message, {
  SnackBarType type = SnackBarType.info,
  String? actionLabel,
  VoidCallback? onAction,
  Duration? duration,
}) {
  // Ensure only one snackbar is visible at a time
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();

  Color? background;
  IconData? icon;
  switch (type) {
    case SnackBarType.success:
      background = AppTheme.success;
      icon = Icons.check_circle_rounded;
      break;
    case SnackBarType.warning:
      background = AppTheme.warning;
      icon = Icons.warning_amber_rounded;
      break;
    case SnackBarType.error:
      background = AppTheme.error;
      icon = Icons.error_rounded;
      break;
    case SnackBarType.info:
      background = null; // Use themed default (snackBarTheme)
      icon = Icons.info_rounded;
      break;
  }

  final textStyle = Theme.of(context).snackBarTheme.contentTextStyle;
  final iconColor = textStyle?.color ?? Colors.white;

  messenger.showSnackBar(
    SnackBar(
      backgroundColor: background,
      behavior: Theme.of(context).snackBarTheme.behavior,
      duration: duration ?? const Duration(milliseconds: 2800),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          Expanded(child: Text(message)),
        ],
      ),
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(label: actionLabel, onPressed: onAction)
          : null,
    ),
  );
}

