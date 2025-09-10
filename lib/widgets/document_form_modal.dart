import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../models/document.dart';
import '../themes/app_theme.dart';
import '../providers/document_provider.dart';
import '../utils/form_validators.dart';
import '../l10n/app_localizations.dart';
import '../utils/snackbar.dart';

class DocumentFormModal extends StatefulWidget {
  final Document? document;

  const DocumentFormModal({
    super.key,
    this.document,
  });

  @override
  State<DocumentFormModal> createState() => _DocumentFormModalState();

  static void show(
    BuildContext context, {
    Document? document,
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
        child: DocumentFormModal(
          document: document,
        ),
      ),
    );
  }
}

class _DocumentFormModalState extends State<DocumentFormModal> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  
  late DocumentType selectedType;
  String? selectedFilePath;
  String? selectedFileName;
  int? selectedFileSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Character count state
  int titleCharCount = 0;
  int descriptionCharCount = 0;
  
  // Validation error state
  String? titleError;
  String? descriptionError;
  String? fileError;
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final document = widget.document;
    
    titleController = TextEditingController(text: document?.title ?? '');
    descriptionController = TextEditingController(text: document?.description ?? '');
    
    selectedType = document?.type ?? DocumentType.passport;
    selectedFilePath = document?.filePath;
    selectedFileName = document?.fileName;
    selectedFileSize = document?.fileSize;
    
    // Initialize character counts
    titleCharCount = titleController.text.length;
    descriptionCharCount = descriptionController.text.length;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


  Future<void> _pickFile() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.selectDocument,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            _buildFilePickerOption(
              icon: Iconsax.camera,
              title: AppLocalizations.of(context)!.takePhoto,
              subtitle: AppLocalizations.of(context)!.captureDocumentWithCamera,
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            const SizedBox(height: 16),
            _buildFilePickerOption(
              icon: Iconsax.gallery,
              title: AppLocalizations.of(context)!.chooseFromGallery,
              subtitle: AppLocalizations.of(context)!.selectFromPhotoLibrary,
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            const SizedBox(height: 16),
            _buildFilePickerOption(
              icon: Iconsax.document,
              title: AppLocalizations.of(context)!.chooseFile,
              subtitle: AppLocalizations.of(context)!.selectPdfOrOtherFiles,
              onTap: () {
                Navigator.pop(context);
                _pickFileFromDevice();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFilePickerOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppTheme.primaryColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Iconsax.arrow_right_3,
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      
      if (image != null) {
        await _processSelectedFile(image.path, image.name);
      }
    } catch (e) {
      _showError(AppLocalizations.of(context)!.failedToCaptureImage);
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image != null) {
        await _processSelectedFile(image.path, image.name);
      }
    } catch (e) {
      _showError(AppLocalizations.of(context)!.failedToSelectImage);
    }
  }

  Future<void> _pickFileFromDevice() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        await _processSelectedFile(file.path!, file.name);
      }
    } catch (e) {
      _showError(AppLocalizations.of(context)!.failedToSelectFile);
    }
  }

  Future<void> _processSelectedFile(String filePath, String fileName) async {
    final file = File(filePath);
    final fileSize = await file.length();
    
    setState(() {
      selectedFilePath = filePath;
      selectedFileName = fileName;
      selectedFileSize = fileSize;
      fileError = null;
    });
  }

  void _showError(String message) {
    showAppSnackBar(context, message, type: SnackBarType.error);
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (selectedFilePath == null && widget.document == null) {
      // Prompt user to select a file (using existing localized label)
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.selectDocument,
        type: SnackBarType.error,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final document = Document(
        id: widget.document?.id ?? const Uuid().v4(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        filePath: selectedFilePath ?? widget.document!.filePath,
        fileName: selectedFileName ?? widget.document!.fileName,
        fileSize: selectedFileSize ?? widget.document!.fileSize,
        type: selectedType,
        isPersonal: true,
        createdAt: widget.document?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final provider = Provider.of<DocumentProvider>(context, listen: false);
      
      if (widget.document == null) {
        // Creating new document
        await provider.createDocument(document);
      } else {
        // Updating existing document
        await provider.updateDocument(document);
      }

      if (mounted) {
        showAppSnackBar(
          context,
          widget.document == null
              ? AppLocalizations.of(context)!.documentAddedSuccessfully
              : AppLocalizations.of(context)!.documentUpdatedSuccessfully,
          type: SnackBarType.success,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          AppLocalizations.of(context)!.failedToSaveDocument,
          type: SnackBarType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.surfaceDark
                  : AppTheme.surfaceLight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
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
                          _buildHeader(),
                          const SizedBox(height: 24),
                          _buildTitleField(),
                          const SizedBox(height: 16),
                          _buildCategoryField(),
                          const SizedBox(height: 16),
                          _buildDescriptionField(),
                          const SizedBox(height: 16),
                          _buildFileField(),
                          const SizedBox(height: 24),
                          _buildButtons(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.document == null ? Iconsax.document_upload : Iconsax.edit_2,
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          widget.document == null ? AppLocalizations.of(context)!.addDocument : AppLocalizations.of(context)!.editDocument,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: titleController,
      maxLength: FormValidators.titleLimit,
      onChanged: (value) {
        setState(() {
          titleCharCount = value.length;
          titleError = FormValidators.validateTitle(value, context);
        });
      },
      decoration: FormValidators.createRequiredInputDecoration(
        labelText: AppLocalizations.of(context)!.documentTitle,
        maxLength: FormValidators.titleLimit,
        context: context,
      ).copyWith(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
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
      validator: (value) => FormValidators.validateTitle(value, context),
      autofocus: true,
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: descriptionController,
      maxLength: FormValidators.descriptionLimit,
      onChanged: (value) {
        setState(() {
          descriptionCharCount = value.length;
          descriptionError = FormValidators.validateDescription(value, context);
        });
      },
      decoration: FormValidators.createOptionalInputDecoration(
        labelText: AppLocalizations.of(context)!.description,
        maxLength: FormValidators.descriptionLimit,
        context: context,
      ).copyWith(
        labelStyle: TextStyle(color: AppTheme.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
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
      validator: (value) => FormValidators.validateDescription(value, context),
      maxLines: 3,
    );
  }

  Widget _buildCategoryField() {
    return DropdownButtonFormField<DocumentType>(
      value: selectedType,
      decoration: FormValidators.createRequiredInputDecoration(
        labelText: AppLocalizations.of(context)!.documentCategory,
        maxLength: 0, // Not applicable for dropdown
        context: context,
      ).copyWith(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        suffixText: null, // Remove character counter for dropdown
      ),
      items: DocumentType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Row(
            children: [
              Icon(_getDocumentTypeIcon(type), size: 16),
              const SizedBox(width: 8),
              Text(_getDocumentTypeDisplayName(type)),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedType = value;
          });
        }
      },
    );
  }

  Widget _buildFileField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: fileError != null 
              ? AppTheme.error 
              : AppTheme.textSecondary.withValues(alpha: 0.3),
        ),
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
                AppLocalizations.of(context)!.uploadDocument,
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
          if (selectedFileName != null) ...[
            const SizedBox(height: 12),
            Container(
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
                    selectedFileName!.toLowerCase().endsWith('.pdf') ? Iconsax.document_text :
                    _isImageFile(selectedFileName!) ? Iconsax.image :
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
                          selectedFileName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (selectedFileSize != null)
                          Text(
                            _formatFileSize(selectedFileSize!),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedFilePath = null;
                        selectedFileName = null;
                        selectedFileSize = null;
                        fileError = null;
                      });
                    },
                    icon: Icon(
                      Iconsax.trash,
                      color: AppTheme.error,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
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
          if (fileError != null) ...[
            const SizedBox(height: 8),
            Text(
              fileError!,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _isImageFile(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
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
              onPressed: _isLoading ? null : _saveDocument,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      widget.document == null ? AppLocalizations.of(context)!.addDocument : AppLocalizations.of(context)!.updateDocument,
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
    );
  }

  String _getDocumentTypeDisplayName(DocumentType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case DocumentType.passport:
        return l10n.passport;
      case DocumentType.visa:
        return l10n.visa;
      case DocumentType.insurance:
        return l10n.insurance;
      case DocumentType.other:
        return l10n.other;
    }
  }

  IconData _getDocumentTypeIcon(DocumentType type) {
    switch (type) {
      case DocumentType.passport:
        return Iconsax.card;
      case DocumentType.visa:
        return Iconsax.card_pos;
      case DocumentType.insurance:
        return Iconsax.shield_tick;
      case DocumentType.other:
        return Iconsax.document;
    }
  }
}
