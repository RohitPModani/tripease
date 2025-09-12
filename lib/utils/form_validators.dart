import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';

/// Centralized form validation utilities for character limits and field validation
class FormValidators {
  // Character limits as specified
  static const int titleLimit = 50;
  static const int descriptionLimit = 100;
  static const int vendorCompanyLimit = 50;
  static const int confirmationNumberLimit = 20;
  static const int paidByLimit = 20;
  static const int locationLimit = 50;
  static const int itineraryDescriptionLimit = 250;

  /// Validates title field with character limit
  static String? validateTitle(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.titleIsRequired;
    }
    if (value.trim().length > titleLimit) {
      return l10n.titleTooLong(titleLimit);
    }
    return null;
  }

  /// Validates description field with character limit
  static String? validateDescription(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value != null && value.trim().length > descriptionLimit) {
      return l10n.descriptionTooLong(descriptionLimit);
    }
    return null;
  }

  /// Validates vendor/company field with character limit
  static String? validateVendorCompany(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value != null && value.trim().length > vendorCompanyLimit) {
      return l10n.vendorTooLong(vendorCompanyLimit);
    }
    return null;
  }

  /// Validates confirmation number field with character limit
  static String? validateConfirmationNumber(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value != null && value.trim().length > confirmationNumberLimit) {
      return l10n.confirmationNumberTooLong(confirmationNumberLimit);
    }
    return null;
  }

  /// Validates paid by field with character limit
  static String? validatePaidBy(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value != null && value.trim().length > paidByLimit) {
      return l10n.paidByTooLong(paidByLimit);
    }
    return null;
  }

  /// Validates location field with character limit
  static String? validateLocation(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value != null && value.trim().length > locationLimit) {
      return l10n.locationTooLong(locationLimit);
    }
    return null;
  }

  /// Validates itinerary description field with character limit
  static String? validateItineraryDescription(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value != null && value.trim().length > itineraryDescriptionLimit) {
      return l10n.itineraryDescriptionTooLong(itineraryDescriptionLimit);
    }
    return null;
  }

  /// Validates amount field (numeric)
  static String? validateAmount(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.amountIsRequired;
    }
    final amount = double.tryParse(value.trim());
    if (amount == null) {
      return l10n.enterValidAmount;
    }
    if (amount < 0) {
      return l10n.amountMustBePositive;
    }
    return null;
  }

  /// Validates required field (not empty)
  static String? validateRequired(String? value, String fieldName, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.fieldIsRequired(fieldName);
    }
    return null;
  }

  /// Validates destination field
  static String? validateDestination(String? value, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.destinationIsRequired;
    }
    if (value.trim().length > locationLimit) {
      return l10n.destinationTooLong(locationLimit);
    }
    return null;
  }


  /// Creates input decoration with character counter
  static InputDecoration createInputDecoration({
    required String labelText,
    required int maxLength,
    required BuildContext context,
    String? helperText,
    bool isRequired = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return InputDecoration(
      label: isRequired 
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: labelText,
                    style: const TextStyle(color: Color(0xFF6B7280)),
                  ),
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppTheme.error),
                  ),
                ],
              ),
            )
          : Text(labelText),
      helperText: helperText,
      counterText: '', // Hide default counter
      suffixText: maxLength > 0 ? l10n.maxCharacters(maxLength) : null,
      suffixStyle: maxLength > 0 ? const TextStyle(fontSize: 12) : null,
    );
  }

  /// Creates input decoration for required fields
  static InputDecoration createRequiredInputDecoration({
    required String labelText,
    required int maxLength,
    required BuildContext context,
    String? helperText,
  }) {
    return createInputDecoration(
      labelText: labelText,
      maxLength: maxLength,
      context: context,
      helperText: helperText,
      isRequired: true,
    );
  }

  /// Creates input decoration for optional fields
  static InputDecoration createOptionalInputDecoration({
    required String labelText,
    required int maxLength,
    required BuildContext context,
    String? helperText,
  }) {
    return createInputDecoration(
      labelText: labelText,
      maxLength: maxLength,
      context: context,
      helperText: helperText,
      isRequired: false,
    );
  }
}
