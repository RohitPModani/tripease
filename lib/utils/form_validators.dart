import 'package:flutter/material.dart';

/// Centralized form validation utilities for character limits and field validation
class FormValidators {
  // Character limits as specified
  static const int titleLimit = 20;
  static const int descriptionLimit = 100;
  static const int vendorCompanyLimit = 50;
  static const int confirmationNumberLimit = 20;
  static const int paidByLimit = 20;
  static const int locationLimit = 50;
  static const int itineraryDescriptionLimit = 250;

  /// Validates title field with character limit
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    if (value.trim().length > titleLimit) {
      return 'Title must be $titleLimit characters or less';
    }
    return null;
  }

  /// Validates description field with character limit
  static String? validateDescription(String? value) {
    if (value != null && value.trim().length > descriptionLimit) {
      return 'Description must be $descriptionLimit characters or less';
    }
    return null;
  }

  /// Validates vendor/company field with character limit
  static String? validateVendorCompany(String? value) {
    if (value != null && value.trim().length > vendorCompanyLimit) {
      return 'Vendor/Company must be $vendorCompanyLimit characters or less';
    }
    return null;
  }

  /// Validates confirmation number field with character limit
  static String? validateConfirmationNumber(String? value) {
    if (value != null && value.trim().length > confirmationNumberLimit) {
      return 'Confirmation number must be $confirmationNumberLimit characters or less';
    }
    return null;
  }

  /// Validates paid by field with character limit
  static String? validatePaidBy(String? value) {
    if (value != null && value.trim().length > paidByLimit) {
      return 'Paid by must be $paidByLimit characters or less';
    }
    return null;
  }

  /// Validates location field with character limit
  static String? validateLocation(String? value) {
    if (value != null && value.trim().length > locationLimit) {
      return 'Location must be $locationLimit characters or less';
    }
    return null;
  }

  /// Validates itinerary description field with character limit
  static String? validateItineraryDescription(String? value) {
    if (value != null && value.trim().length > itineraryDescriptionLimit) {
      return 'Description must be $itineraryDescriptionLimit characters or less';
    }
    return null;
  }

  /// Validates amount field (numeric)
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value.trim());
    if (amount == null) {
      return 'Please enter a valid amount';
    }
    if (amount < 0) {
      return 'Amount must be positive';
    }
    return null;
  }

  /// Validates required field (not empty)
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates destination field
  static String? validateDestination(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Destination is required';
    }
    if (value.trim().length > locationLimit) {
      return 'Destination must be $locationLimit characters or less';
    }
    return null;
  }


  /// Creates input decoration with character counter
  static InputDecoration createInputDecoration({
    required String labelText,
    required int maxLength,
    String? helperText,
    bool isRequired = false,
  }) {
    return InputDecoration(
      labelText: isRequired ? labelText : '$labelText (Optional)',
      helperText: helperText,
      counterText: '', // Hide default counter
      suffixText: '${maxLength} max',
      suffixStyle: const TextStyle(fontSize: 12),
    );
  }

  /// Creates input decoration for required fields
  static InputDecoration createRequiredInputDecoration({
    required String labelText,
    required int maxLength,
    String? helperText,
  }) {
    return createInputDecoration(
      labelText: labelText,
      maxLength: maxLength,
      helperText: helperText,
      isRequired: true,
    );
  }

  /// Creates input decoration for optional fields
  static InputDecoration createOptionalInputDecoration({
    required String labelText,
    required int maxLength,
    String? helperText,
  }) {
    return createInputDecoration(
      labelText: labelText,
      maxLength: maxLength,
      helperText: helperText,
      isRequired: false,
    );
  }
}
