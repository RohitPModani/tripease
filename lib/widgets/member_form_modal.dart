import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../models/trip_member.dart';
import '../themes/app_theme.dart';
import '../providers/trip_member_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/snackbar.dart';
import 'form_error_display.dart';

class MemberFormModal extends StatefulWidget {
  final String tripId;
  final TripMember? member;

  const MemberFormModal({
    super.key,
    required this.tripId,
    this.member,
  });

  static void show(
    BuildContext context,
    String tripId, {
    TripMember? member,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: MemberFormModal(
          tripId: tripId,
          member: member,
        ),
      ),
    );
  }

  @override
  State<MemberFormModal> createState() => _MemberFormModalState();
}

class _MemberFormModalState extends State<MemberFormModal> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Character count state
  int nameCharCount = 0;
  int emailCharCount = 0;
  
  // Validation error state
  String? nameError;
  String? emailError;
  
  // Form submission error state
  String? formError;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.member?.name ?? '');
    emailController = TextEditingController(text: widget.member?.email ?? '');
    
    // Initialize character counts
    nameCharCount = nameController.text.length;
    emailCharCount = emailController.text.length;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.member != null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.surfaceDark
                : AppTheme.surfaceLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Iconsax.people,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              isEdit ? 'Edit Trip Member' : 'Add Trip Member',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        FormErrorDisplay(error: formError),
                        TextFormField(
                          controller: nameController,
                          maxLength: 50,
                          onChanged: (value) {
                            setState(() {
                              nameCharCount = value.length;
                              nameError = _validateName(value);
                              // Clear form error when user starts typing
                              if (formError != null) {
                                formError = null;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Name *',
                            labelStyle: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            counterText: '',
                            suffixText: '$nameCharCount/50',
                            suffixStyle: TextStyle(
                              fontSize: 12,
                              color: nameCharCount > 50 
                                  ? AppTheme.error 
                                  : AppTheme.textSecondary,
                            ),
                            errorText: nameError,
                          ),
                          validator: (value) => _validateName(value),
                          autofocus: !isEdit,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          maxLength: 100,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              emailCharCount = value.length;
                              emailError = _validateEmail(value);
                              // Clear form error when user starts typing
                              if (formError != null) {
                                formError = null;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Email (optional)',
                            labelStyle: TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            counterText: '',
                            suffixText: '$emailCharCount/100',
                            suffixStyle: TextStyle(
                              fontSize: 12,
                              color: emailCharCount > 100 
                                  ? AppTheme.error 
                                  : AppTheme.textSecondary,
                            ),
                            errorText: emailError,
                          ),
                          validator: (value) => _validateEmail(value),
                        ),
                        const SizedBox(height: 8),
                        Consumer<TripMemberProvider>(
                          builder: (context, memberProvider, child) {
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppTheme.primaryColor.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.info_circle,
                                    color: AppTheme.primaryColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Trip members: ${memberProvider.memberCount}/8 (Max 8 members)',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(
                                    color: AppTheme.textSecondary.withValues(alpha: 0.3),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: TextStyle(color: AppTheme.textSecondary),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                decoration: AppTheme.glowingButtonDecoration,
                                child: ElevatedButton(
                                  onPressed: isSubmitting ? null : () async {
                                    await _handleSubmit();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isSubmitting 
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : Text(
                                        isEdit ? 'Update Member' : 'Add Member',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is optional
    }
    if (value.length > 100) {
      return 'Email must not exceed 100 characters';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSubmitting = true;
      formError = null;
    });

    final memberProvider = Provider.of<TripMemberProvider>(context, listen: false);
    
    try {
      if (widget.member != null) {
        // Update existing member
        final updatedMember = widget.member!.copyWith(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        );
        
        final success = await memberProvider.updateMember(updatedMember);
        if (!mounted) return;
        
        if (success) {
          Navigator.pop(context);
          showAppSnackBar(
            context,
            'Member updated successfully',
            type: SnackBarType.success,
          );
        } else {
          setState(() {
            isSubmitting = false;
            formError = memberProvider.error ?? 'Failed to update member. Please try again.';
          });
        }
      } else {
        // Add new member
        final member = await memberProvider.addMember(
          tripId: widget.tripId,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        );
        if (!mounted) return;
        
        if (member != null) {
          Navigator.pop(context);
          showAppSnackBar(
            context,
            'Member added successfully',
            type: SnackBarType.success,
          );
        } else {
          setState(() {
            isSubmitting = false;
            formError = memberProvider.error ?? 'Failed to add member. Please try again.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isSubmitting = false;
          formError = 'An unexpected error occurred. Please try again.';
        });
      }
    }
  }
}