import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gal/gal.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../widgets/document_form_modal.dart';
import '../widgets/document_viewer.dart';
import '../providers/document_provider.dart';
import '../models/document.dart';
import '../models/attachment.dart';
import '../utils/snackbar.dart';

enum DocumentFilter { all, passport, visa, insurance, other }

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  String _searchQuery = '';
  DocumentFilter _selectedFilter = DocumentFilter.all;
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DocumentProvider>(context, listen: false);
      provider.loadPersonalDocuments();
      // Note: If trip documents were implemented, we'd also need to load them here
      // provider.loadDocuments(currentTripId);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Document> _getFilteredDocuments(List<Document> documents) {
    List<Document> filteredDocuments = documents;
    
    // Apply filter by document type/category
    switch (_selectedFilter) {
      case DocumentFilter.all:
        // Show all documents
        break;
      case DocumentFilter.passport:
        filteredDocuments = filteredDocuments.where((doc) => doc.type == DocumentType.passport).toList();
        break;
      case DocumentFilter.visa:
        filteredDocuments = filteredDocuments.where((doc) => doc.type == DocumentType.visa).toList();
        break;
      case DocumentFilter.insurance:
        filteredDocuments = filteredDocuments.where((doc) => doc.type == DocumentType.insurance).toList();
        break;
      case DocumentFilter.other:
        filteredDocuments = filteredDocuments.where((doc) => doc.type == DocumentType.other).toList();
        break;
    }
    
    // Apply search query filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filteredDocuments = filteredDocuments.where((document) {
        return document.title.toLowerCase().contains(query) ||
               document.description.toLowerCase().contains(query) ||
               document.fileName.toLowerCase().contains(query) ||
               _getDocumentTypeDisplayName(document.type).toLowerCase().contains(query);
      }).toList();
    }
    
    return filteredDocuments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.backgroundDark
                  : AppTheme.backgroundLight,
              Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.surfaceDark.withValues(alpha: 0.8)
                  : AppTheme.surfaceLight.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildFilterChips(),
                    const SizedBox(height: 8),
                  ]),
                ),
              ),
              SliverFillRemaining(
                child: _buildPersonalDocuments(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<DocumentProvider>(
        builder: (context, documentProvider, child) => Container(
          decoration: AppTheme.glowingButtonDecoration,
          child: FloatingActionButton.extended(
            heroTag: "add_document_fab",
            onPressed: () => _showAddDocumentDialog(documentProvider),
            backgroundColor: Colors.transparent,
            elevation: 0,
            icon: const Icon(
              Iconsax.add,
              color: Colors.white,
            ),
            label: Text(
              AppLocalizations.of(context)!.addDocument,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildAppBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 80,
      floating: true,
      pinned: true,
      backgroundColor: isDark
          ? AppTheme.backgroundDark
          : AppTheme.backgroundLight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          'Documents',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            foreground: Paint()
              ..shader = AppTheme.primaryGradient.createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchDocuments,
          prefixIcon: const Icon(Iconsax.search_normal_1),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Iconsax.close_circle),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildPersonalDocuments() {
    return Consumer<DocumentProvider>(
      builder: (context, documentProvider, child) {
        if (documentProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (documentProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.warning_2,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  '${AppLocalizations.of(context)!.failedToLoad} documents',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  documentProvider.error!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => documentProvider.loadPersonalDocuments(),
                  child: Text(AppLocalizations.of(context)!.retry),
                ),
              ],
            ),
          );
        }

        final allDocuments = documentProvider.personalDocuments;
        final documents = _getFilteredDocuments(allDocuments);

        if (allDocuments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.document,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'No documents yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first document to get started!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }

        if (documents.isEmpty && (_searchQuery.isNotEmpty || _selectedFilter != DocumentFilter.all)) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.search_normal_1,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'No documents found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search terms or filters',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                      _selectedFilter = DocumentFilter.all;
                    });
                  },
                  icon: const Icon(Iconsax.refresh),
                  label: Text('Clear Filters'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }

        return AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildDocumentCard(documents[index]),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }


  Widget _buildDocumentCard(Document document) {
    return Dismissible(
      key: Key(document.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Delete action
          return await _showDeleteConfirmationDialog(document);
        } else if (direction == DismissDirection.startToEnd) {
          // Edit action - don't dismiss, just open edit dialog
          DocumentFormModal.show(context, document: document);
          return false;
        }
        return false;
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Perform deletion
          try {
            await Provider.of<DocumentProvider>(context, listen: false)
                .deleteDocument(document.id);
            
            if (mounted) {
              showAppSnackBar(
                context,
                AppLocalizations.of(context)!.documentDeletedSuccessfully(document.title),
                type: SnackBarType.success,
              );
            }
          } catch (e) {
            if (mounted) {
              showAppSnackBar(
                context,
                AppLocalizations.of(context)!.failedToDeleteDocument(e.toString()),
                type: SnackBarType.error,
              );
            }
          }
        }
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.edit_2,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.edit,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Iconsax.trash,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getDocumentTypeColor(document.type.name).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showDocumentDetailsBottomSheet(document);
          },
          child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getDocumentTypeColor(document.type.name).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getDocumentTypeIcon(document.type.name),
                  color: _getDocumentTypeColor(document.type.name),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          _getDocumentTypeDisplayName(document.type),
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.textSecondaryDark
                                : AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Iconsax.calendar_1,
                          size: 12,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Created: ${_formatDate(document.createdAt)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.textSecondaryDark
                                : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary).withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  _formatFileSize(document.fileSize),
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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

  Future<bool> _showDeleteConfirmationDialog(Document document) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteDocument),
        content: Text(AppLocalizations.of(context)!.deleteDocumentConfirmation(document.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context, true);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.error,
            ),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    ) ?? false;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getDocumentTypeDisplayName(DocumentType type) {
    switch (type) {
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.visa:
        return 'Visa';
      case DocumentType.insurance:
        return 'Insurance';
      case DocumentType.other:
        return 'Other';
    }
  }

  void _showDocumentDetailsBottomSheet(Document document) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
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
                color: (Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _getDocumentTypeColor(document.type.name).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getDocumentTypeIcon(document.type.name),
                            color: _getDocumentTypeColor(document.type.name),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Document Details',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _getDocumentTypeDisplayName(document.type),
                                style: TextStyle(
                                  color: _getDocumentTypeColor(document.type.name),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      document.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (document.description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        document.description,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Created Date',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.calendar_1,
                                    size: 16,
                                    color: Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.textSecondaryDark
                                : AppTheme.textSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _formatDate(document.createdAt),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'File Size',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatFileSize(document.fileSize),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'File Name',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      document.fileName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Attachments Section (Document File)
                    Text(
                      AppLocalizations.of(context)!.attachments,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                            _getDocumentFileIcon(document),
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document.fileName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  _formatFileSize(document.fileSize),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.textSecondaryDark
                                : AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => _viewDocument(document),
                            icon: Icon(
                              Iconsax.eye,
                              color: AppTheme.primaryColor,
                              size: 26,
                            ),
                            tooltip: AppLocalizations.of(context)!.view,
                          ),
                          IconButton(
                            onPressed: () => _downloadDocument(document),
                            icon: Icon(
                              Iconsax.document_download,
                              color: AppTheme.secondaryColor,
                              size: 24,
                            ),
                            tooltip: AppLocalizations.of(context)!.download,
                          ),
                          IconButton(
                            onPressed: () => _shareDocument(document),
                            icon: Icon(
                              Iconsax.share,
                              color: AppTheme.accentColor,
                              size: 24,
                            ),
                            tooltip: AppLocalizations.of(context)!.share,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Edit and Delete buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              DocumentFormModal.show(context, document: document);
                            },
                            icon: const Icon(Iconsax.edit_2),
                            label: Text(AppLocalizations.of(context)!.edit),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showDeleteConfirmationDialog(document);
                            },
                            icon: const Icon(Iconsax.trash),
                            label: Text(AppLocalizations.of(context)!.delete),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _viewDocument(Document document) async {
    final attachment = _documentToAttachment(document);
    DocumentViewer.show(context, attachment);
  }

  BookingAttachment _documentToAttachment(Document document) {
    // Determine MIME type based on file extension
    String mimeType = 'application/octet-stream'; // default
    final extension = document.fileName.toLowerCase().split('.').last;
    
    switch (extension) {
      case 'pdf':
        mimeType = 'application/pdf';
        break;
      case 'jpg':
      case 'jpeg':
        mimeType = 'image/jpeg';
        break;
      case 'png':
        mimeType = 'image/png';
        break;
      case 'gif':
        mimeType = 'image/gif';
        break;
      case 'bmp':
        mimeType = 'image/bmp';
        break;
      case 'webp':
        mimeType = 'image/webp';
        break;
      case 'doc':
        mimeType = 'application/msword';
        break;
      case 'docx':
        mimeType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        break;
      case 'txt':
        mimeType = 'text/plain';
        break;
    }

    return BookingAttachment(
      id: document.id,
      fileName: document.fileName,
      filePath: document.filePath,
      mimeType: mimeType,
      fileSize: document.fileSize,
      uploadedAt: document.createdAt,
    );
  }

  Future<void> _downloadDocument(Document document) async {
    try {
      final file = File(document.filePath);
      if (!await file.exists()) {
        if (!mounted) return;
        showAppSnackBar(context, AppLocalizations.of(context)!.fileNotFound, type: SnackBarType.error);
        return;
      }

      // For images, offer choice between gallery and file save
      if (document.isImage) {
        await _showImageDownloadOptions(document, file);
      } else {
        // For documents, use file save dialog
        await _saveFileWithDialog(document, file);
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          AppLocalizations.of(context)!.errorDownloadingFile(e.toString()),
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _shareDocument(Document document) async {
    try {
      final file = File(document.filePath);
      if (await file.exists()) {
        await Share.shareXFiles(
          [XFile(document.filePath)],
          subject: document.title,
          text: document.description.isNotEmpty ? document.description : null,
        );
      } else {
        if (!mounted) return;
        showAppSnackBar(context, AppLocalizations.of(context)!.fileNotFound, type: SnackBarType.error);
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          AppLocalizations.of(context)!.errorSharingFile(e.toString()),
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _showImageDownloadOptions(Document document, File file) async {
    final parentContext = context;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Download Image',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: Text(AppLocalizations.of(context)!.saveToGallery),
              onTap: () async {
                Navigator.pop(context);
                try {
                  await Gal.putImage(document.filePath);
                  if (!parentContext.mounted) return;
                  showAppSnackBar(
                    parentContext,
                    AppLocalizations.of(parentContext)!.imageSavedToPhotos,
                    type: SnackBarType.success,
                  );
                } catch (e) {
                  if (!parentContext.mounted) return;
                  showAppSnackBar(
                    parentContext,
                    AppLocalizations.of(parentContext)!.errorSavingToPhotos(e.toString()),
                    type: SnackBarType.error,
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.folder),
              title: Text(AppLocalizations.of(context)!.saveToFiles),
              onTap: () async {
                Navigator.pop(context);
                await _saveFileWithDialog(document, file);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveFileWithDialog(Document document, File file) async {
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save ${document.fileName}',
        fileName: document.fileName,
        bytes: await file.readAsBytes(),
      );
      
      if (result != null && mounted) {
        showAppSnackBar(
          context,
          AppLocalizations.of(context)!.fileSavedSuccessfully,
          type: SnackBarType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          AppLocalizations.of(context)!.errorSavingFile(e.toString()),
          type: SnackBarType.error,
        );
      }
    }
  }

  IconData _getDocumentFileIcon(Document document) {
    if (document.isImage) {
      return Iconsax.image;
    }
    
    final extension = document.fileName.toLowerCase().split('.').last;
    switch (extension) {
      case 'pdf':
        return Iconsax.document_text;
      case 'doc':
      case 'docx':
        return Iconsax.document_text;
      case 'txt':
        return Iconsax.document_text;
      default:
        return Iconsax.document;
    }
  }

  Color _getDocumentTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'passport':
        return AppTheme.warning;
      case 'visa':
        return AppTheme.secondaryColor;
      case 'insurance':
        return AppTheme.success;
      case 'other':
        return AppTheme.textSecondary;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getDocumentTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'passport':
        return Iconsax.card;
      case 'visa':
        return Iconsax.card_pos;
      case 'ticket':
        return Iconsax.ticket;
      case 'hotel':
        return Iconsax.building;
      case 'insurance':
        return Iconsax.shield_tick;
      case 'other':
        return Iconsax.document;
      default:
        return Iconsax.document;
    }
  }

  Widget _buildFilterChips() {
    return Consumer<DocumentProvider>(
      builder: (context, documentProvider, child) {
        final documents = documentProvider.personalDocuments;
        final passportDocs = documents.where((doc) => doc.type == DocumentType.passport).length;
        final visaDocs = documents.where((doc) => doc.type == DocumentType.visa).length;
        final insuranceDocs = documents.where((doc) => doc.type == DocumentType.insurance).length;
        final otherDocs = documents.where((doc) => doc.type == DocumentType.other).length;

        return SizedBox(
          height: 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
            children: [
              FilterChip(
                label: Text(AppLocalizations.of(context)!.allWithCount(documents.length)),
                selected: _selectedFilter == DocumentFilter.all,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = DocumentFilter.all;
                  });
                },
                selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                checkmarkColor: AppTheme.primaryColor,
                labelStyle: TextStyle(
                  color: _selectedFilter == DocumentFilter.all ? AppTheme.primaryColor : null,
                  fontWeight: _selectedFilter == DocumentFilter.all ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.passport} ($passportDocs)'),
                selected: _selectedFilter == DocumentFilter.passport,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = DocumentFilter.passport;
                  });
                },
                selectedColor: _getDocumentTypeColor('passport').withValues(alpha: 0.2),
                checkmarkColor: _getDocumentTypeColor('passport'),
                labelStyle: TextStyle(
                  color: _selectedFilter == DocumentFilter.passport ? _getDocumentTypeColor('passport') : null,
                  fontWeight: _selectedFilter == DocumentFilter.passport ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.visa} ($visaDocs)'),
                selected: _selectedFilter == DocumentFilter.visa,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = DocumentFilter.visa;
                  });
                },
                selectedColor: _getDocumentTypeColor('visa').withValues(alpha: 0.2),
                checkmarkColor: _getDocumentTypeColor('visa'),
                labelStyle: TextStyle(
                  color: _selectedFilter == DocumentFilter.visa ? _getDocumentTypeColor('visa') : null,
                  fontWeight: _selectedFilter == DocumentFilter.visa ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.insurance} ($insuranceDocs)'),
                selected: _selectedFilter == DocumentFilter.insurance,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = DocumentFilter.insurance;
                  });
                },
                selectedColor: _getDocumentTypeColor('insurance').withValues(alpha: 0.2),
                checkmarkColor: _getDocumentTypeColor('insurance'),
                labelStyle: TextStyle(
                  color: _selectedFilter == DocumentFilter.insurance ? _getDocumentTypeColor('insurance') : null,
                  fontWeight: _selectedFilter == DocumentFilter.insurance ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.other} ($otherDocs)'),
                selected: _selectedFilter == DocumentFilter.other,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = DocumentFilter.other;
                  });
                },
                selectedColor: _getDocumentTypeColor('other').withValues(alpha: 0.2),
                checkmarkColor: _getDocumentTypeColor('other'),
                labelStyle: TextStyle(
                  color: _selectedFilter == DocumentFilter.other ? _getDocumentTypeColor('other') : null,
                  fontWeight: _selectedFilter == DocumentFilter.other ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
          ),
        );
      },
    );
  }

  void _showAddDocumentDialog(DocumentProvider documentProvider) {
    // Check if document limit is reached (10 total)
    if (documentProvider.personalDocuments.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.documentLimitReached),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    DocumentFormModal.show(context);
  }
}
