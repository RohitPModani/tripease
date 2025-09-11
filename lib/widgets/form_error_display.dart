import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';

class FormErrorDisplay extends StatelessWidget {
  final String? error;
  final EdgeInsets? margin;

  const FormErrorDisplay({
    super.key,
    required this.error,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    if (error == null) return const SizedBox.shrink();
    
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.warning_2,
            color: AppTheme.error,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error!,
              style: TextStyle(
                color: AppTheme.error,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}