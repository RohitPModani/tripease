import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/booking.dart';
import '../models/attachment.dart';
import '../themes/app_theme.dart';
import '../providers/booking_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/form_validators.dart';

class BookingFormModal extends StatefulWidget {
  final String tripId;
  final String defaultCurrency;
  final Booking? booking;

  const BookingFormModal({
    super.key,
    required this.tripId,
    required this.defaultCurrency,
    this.booking,
  });

  @override
  State<BookingFormModal> createState() => _BookingFormModalState();

  static void show(
    BuildContext context,
    String tripId,
    String defaultCurrency, {
    Booking? booking,
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
        child: BookingFormModal(
          tripId: tripId,
          defaultCurrency: defaultCurrency,
          booking: booking,
        ),
      ),
    );
  }
}

class _BookingFormModalState extends State<BookingFormModal> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController vendorController;
  late final TextEditingController confirmationController;
  late final TextEditingController amountController;
  
  late BookingType selectedType;
  late BookingStatus selectedStatus;
  DateTime? selectedDate;
  List<BookingAttachment> attachments = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Character count state
  int titleCharCount = 0;
  int descriptionCharCount = 0;
  int vendorCharCount = 0;
  int confirmationCharCount = 0;
  
  // Validation error state
  String? titleError;
  String? descriptionError;
  String? vendorError;
  String? confirmationError;

  @override
  void initState() {
    super.initState();
    final booking = widget.booking;
    
    titleController = TextEditingController(text: booking?.title ?? '');
    descriptionController = TextEditingController(text: booking?.description ?? '');
    vendorController = TextEditingController(text: booking?.vendor ?? '');
    confirmationController = TextEditingController(text: booking?.confirmationNumber ?? '');
    amountController = TextEditingController(text: booking?.amount.toString() ?? '');
    
    selectedType = booking?.type ?? BookingType.flight;
    selectedStatus = booking?.status ?? BookingStatus.pending;
    selectedDate = booking?.bookingDate;
    attachments = List.from(booking?.attachments ?? []);
    
    // Initialize character counts
    titleCharCount = titleController.text.length;
    descriptionCharCount = descriptionController.text.length;
    vendorCharCount = vendorController.text.length;
    confirmationCharCount = confirmationController.text.length;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    vendorController.dispose();
    confirmationController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'gif'],
        withData: true,
        withReadStream: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        
        // Check if file has data
        if (file.bytes == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.failedToReadFile),
              backgroundColor: AppTheme.error,
            ),
          );
          return;
        }
        
        // Check file size (5MB limit)
        if (file.size > 5 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.fileSizeMustBeLess),
              backgroundColor: AppTheme.error,
            ),
          );
          return;
        }

        // Copy file to app documents directory
        final appDir = await getApplicationDocumentsDirectory();
        final attachmentsDir = Directory(p.join(appDir.path, 'attachments'));
        if (!await attachmentsDir.exists()) {
          await attachmentsDir.create(recursive: true);
        }

        final fileName = '${const Uuid().v4()}_${file.name}';
        final newFile = File(p.join(attachmentsDir.path, fileName));
        await newFile.writeAsBytes(file.bytes!);

        final attachment = BookingAttachment(
          id: const Uuid().v4(),
          fileName: file.name,
          filePath: newFile.path,
          mimeType: _getMimeType(file.extension ?? ''),
          fileSize: file.size,
          uploadedAt: DateTime.now(),
        );

        setState(() {
          attachments.add(attachment);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.fileAttachedSuccessfully(file.name)),
            backgroundColor: AppTheme.success,
          ),
        );
      }
    } catch (e) {
      print('File picker error: $e'); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.failedToPickFile(e.toString())),
          backgroundColor: AppTheme.error,
        ),
      );
    }
  }

  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      default:
        return 'application/octet-stream';
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.booking != null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
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
                color: AppTheme.textSecondary.withOpacity(0.3),
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
                            color: AppTheme.secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Iconsax.airplane,
                            color: AppTheme.secondaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isEdit ? AppLocalizations.of(context)!.editBooking : AppLocalizations.of(context)!.addNewBooking,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: titleController,
                      maxLength: FormValidators.titleLimit,
                      onChanged: (value) {
                        setState(() {
                          titleCharCount = value.length;
                          titleError = FormValidators.validateTitle(value);
                        });
                      },
                      decoration: FormValidators.createRequiredInputDecoration(
                        labelText: AppLocalizations.of(context)!.bookingTitle,
                        maxLength: FormValidators.titleLimit,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        counterText: '',
                        suffixText: '$titleCharCount/${FormValidators.titleLimit}',
                        suffixStyle: TextStyle(
                          fontSize: 12,
                          color: titleCharCount > FormValidators.titleLimit 
                              ? AppTheme.error 
                              : AppTheme.textSecondary,
                        ),
                        errorText: titleError,
                      ),
                      validator: FormValidators.validateTitle,
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<BookingType>(
                      value: selectedType,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.bookingType,
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: BookingType.values
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(_getTypeIcon(type), size: 16),
                                    const SizedBox(width: 8),
                                    Text(type.name),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      maxLength: FormValidators.descriptionLimit,
                      onChanged: (value) {
                        setState(() {
                          descriptionCharCount = value.length;
                          descriptionError = FormValidators.validateDescription(value);
                        });
                      },
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: AppLocalizations.of(context)!.descriptionOptional,
                        maxLength: FormValidators.descriptionLimit,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        counterText: '',
                        suffixText: '$descriptionCharCount/${FormValidators.descriptionLimit}',
                        suffixStyle: TextStyle(
                          fontSize: 12,
                          color: descriptionCharCount > FormValidators.descriptionLimit 
                              ? AppTheme.error 
                              : AppTheme.textSecondary,
                        ),
                        errorText: descriptionError,
                      ),
                      validator: FormValidators.validateDescription,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: vendorController,
                      maxLength: FormValidators.vendorCompanyLimit,
                      onChanged: (value) {
                        setState(() {
                          vendorCharCount = value.length;
                          vendorError = FormValidators.validateVendorCompany(value);
                        });
                      },
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: AppLocalizations.of(context)!.vendorCompanyOptional,
                        maxLength: FormValidators.vendorCompanyLimit,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        counterText: '',
                        suffixText: '$vendorCharCount/${FormValidators.vendorCompanyLimit}',
                        suffixStyle: TextStyle(
                          fontSize: 12,
                          color: vendorCharCount > FormValidators.vendorCompanyLimit 
                              ? AppTheme.error 
                              : AppTheme.textSecondary,
                        ),
                        errorText: vendorError,
                      ),
                      validator: FormValidators.validateVendorCompany,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: confirmationController,
                      maxLength: FormValidators.confirmationNumberLimit,
                      onChanged: (value) {
                        setState(() {
                          confirmationCharCount = value.length;
                          confirmationError = FormValidators.validateConfirmationNumber(value);
                        });
                      },
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: AppLocalizations.of(context)!.confirmationNumberOptional,
                        maxLength: FormValidators.confirmationNumberLimit,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.error, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        counterText: '',
                        suffixText: '$confirmationCharCount/${FormValidators.confirmationNumberLimit}',
                        suffixStyle: TextStyle(
                          fontSize: 12,
                          color: confirmationCharCount > FormValidators.confirmationNumberLimit 
                              ? AppTheme.error 
                              : AppTheme.textSecondary,
                        ),
                        errorText: confirmationError,
                      ),
                      validator: FormValidators.validateConfirmationNumber,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.amountCurrency(widget.defaultCurrency),
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      validator: FormValidators.validateAmount,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<BookingStatus>(
                      value: selectedStatus,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.status,
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: BookingStatus.values
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(status),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(status.name),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedStatus = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: AppTheme.primaryColor,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.calendar_1,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              selectedDate == null
                                  ? AppLocalizations.of(context)!.setBookingDateOptional
                                  : AppLocalizations.of(context)!.dateWithDate(selectedDate!.day, selectedDate!.month, selectedDate!.year),
                              style: TextStyle(
                                color: selectedDate == null 
                                  ? AppTheme.textSecondary 
                                  : Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                            const Spacer(),
                            if (selectedDate != null)
                              IconButton(
                                icon: Icon(
                                  Iconsax.close_circle,
                                  color: AppTheme.textSecondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedDate = null;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Attachments Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.document_upload,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.attachmentsOptional,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const Spacer(),
                              TextButton.icon(
                                onPressed: _pickFile,
                                icon: const Icon(Iconsax.add_circle, size: 18),
                                label: Text(AppLocalizations.of(context)!.addFile),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          if (attachments.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            ...attachments.asMap().entries.map((entry) {
                              final index = entry.key;
                              final attachment = entry.value;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppTheme.primaryColor.withOpacity(0.2),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      attachment.isPdf ? Iconsax.document_text :
                                      attachment.isImage ? Iconsax.image :
                                      Iconsax.document,
                                      color: AppTheme.primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            attachment.fileName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            attachment.displaySize,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _removeAttachment(index),
                                      icon: Icon(
                                        Iconsax.trash,
                                        color: AppTheme.error,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ] else
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                AppLocalizations.of(context)!.maxFileSizeSupported,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
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
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;

                                final bookingItem = Booking(
                                  id: widget.booking?.id ?? const Uuid().v4(),
                                  tripId: widget.tripId,
                                  title: titleController.text.trim(),
                                  type: selectedType,
                                  description: descriptionController.text.trim(),
                                  vendor: vendorController.text.trim(),
                                  confirmationNumber: confirmationController.text.trim(),
                                  bookingDate: selectedDate,
                                  amount: double.tryParse(amountController.text) ?? 0.0,
                                  status: selectedStatus,
                                  attachments: attachments,
                                  createdAt: widget.booking?.createdAt ?? DateTime.now(),
                                  updatedAt: DateTime.now(),
                                );

                                try {
                                  if (isEdit) {
                                    await Provider.of<BookingProvider>(context, listen: false)
                                        .updateBooking(bookingItem);
                                  } else {
                                    await Provider.of<BookingProvider>(context, listen: false)
                                        .createBooking(bookingItem);
                                  }
                                  Navigator.pop(context);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppLocalizations.of(context)!.failedToAddUpdateBooking(isEdit ? 'update' : 'add', e.toString())),
                                      backgroundColor: AppTheme.error,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                isEdit ? AppLocalizations.of(context)!.updateBooking : AppLocalizations.of(context)!.addBooking,
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

  IconData _getTypeIcon(BookingType type) {
    switch (type) {
      case BookingType.flight:
        return Iconsax.airplane;
      case BookingType.hotel:
        return Iconsax.home_2;
      case BookingType.transport:
        return Iconsax.car;
      case BookingType.activity:
        return Iconsax.activity;
      case BookingType.other:
        return Iconsax.document;
      case BookingType.restaurant:
        return Iconsax.cup;
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return AppTheme.warning;
      case BookingStatus.confirmed:
        return AppTheme.success;
      case BookingStatus.cancelled:
        return AppTheme.error;
    }
  }
}