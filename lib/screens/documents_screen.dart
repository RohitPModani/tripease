import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  ? AppTheme.surfaceDark.withOpacity(0.8)
                  : AppTheme.surfaceLight.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildSearchBar(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPersonalDocuments(),
                    _buildTripDocuments(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: AppTheme.glowingButtonDecoration,
        child: FloatingActionButton(
          onPressed: () {
            _showUploadDialog();
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Iconsax.document_upload,
            size: 24,
            color: AppTheme.textLight,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'Documents',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w700,
              foreground: Paint()
                ..shader = AppTheme.primaryGradient.createShader(
                  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                // TODO: Implement document scanner
              },
              icon: const Icon(
                Iconsax.scan,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: TextField(
          onChanged: (value) {
            // TODO: Implement search filtering
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchDocuments,
            prefixIcon: const Icon(Iconsax.search_normal_1),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        dividerColor: Colors.transparent,
        labelColor: AppTheme.textLight,
        unselectedLabelColor: AppTheme.textSecondary,
        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: AppLocalizations.of(context)!.personal),
          Tab(text: AppLocalizations.of(context)!.tripRelated),
        ],
      ),
    );
  }

  Widget _buildPersonalDocuments() {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockPersonalDocuments.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildDocumentCard(_mockPersonalDocuments[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTripDocuments() {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockTripDocuments.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildDocumentCard(_mockTripDocuments[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    final isExpiring = document['isExpiring'] ?? false;
    final isExpired = document['isExpired'] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Open document
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getDocumentTypeColor(document['type']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getDocumentTypeIcon(document['type']),
                    color: _getDocumentTypeColor(document['type']),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document['title'],
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            document['type'],
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppTheme.textSecondary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            document['size'],
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      if (document['expiryDate'] != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Iconsax.calendar,
                              size: 12,
                              color: isExpired ? AppTheme.error : 
                                     isExpiring ? AppTheme.warning : AppTheme.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Expires: ${document['expiryDate']}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isExpired ? AppTheme.error : 
                                       isExpiring ? AppTheme.warning : AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Iconsax.more,
                    color: AppTheme.textSecondary,
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case 'view':
                        // TODO: View document
                        break;
                      case 'share':
                        // TODO: Share document
                        break;
                      case 'download':
                        // TODO: Download document
                        break;
                      case 'delete':
                        // TODO: Delete document
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'view', child: Text('View')),
                    const PopupMenuItem(value: 'share', child: Text('Share')),
                    const PopupMenuItem(value: 'download', child: Text('Download')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUploadDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                color: AppTheme.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Upload Document',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            _buildUploadOption(
              icon: Iconsax.camera,
              title: AppLocalizations.of(context)!.takePhoto,
              subtitle: AppLocalizations.of(context)!.captureDocumentWithCamera,
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement camera capture
              },
            ),
            const SizedBox(height: 16),
            _buildUploadOption(
              icon: Iconsax.gallery,
              title: AppLocalizations.of(context)!.chooseFromGallery,
              subtitle: AppLocalizations.of(context)!.selectFromPhotoLibrary,
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement gallery selection
              },
            ),
            const SizedBox(height: 16),
            _buildUploadOption(
              icon: Iconsax.document,
              title: AppLocalizations.of(context)!.chooseFile,
              subtitle: AppLocalizations.of(context)!.selectPdfOrOtherFiles,
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement file selection
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadOption({
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
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
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

  Color _getDocumentTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'passport':
        return AppTheme.primaryColor;
      case 'visa':
        return AppTheme.secondaryColor;
      case 'ticket':
        return AppTheme.accentColor;
      case 'insurance':
        return AppTheme.success;
      case 'license':
        return AppTheme.warning;
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
      case 'insurance':
        return Iconsax.shield_tick;
      case 'license':
        return Iconsax.driver;
      default:
        return Iconsax.document;
    }
  }

  final List<Map<String, dynamic>> _mockPersonalDocuments = [
    {
      'title': 'US Passport',
      'type': 'Passport',
      'size': '2.4 MB',
      'expiryDate': '2028-05-15',
      'isExpiring': false,
      'isExpired': false,
    },
    {
      'title': 'Driver License',
      'type': 'License',
      'size': '1.8 MB',
      'expiryDate': '2025-12-20',
      'isExpiring': true,
      'isExpired': false,
    },
    {
      'title': 'Travel Insurance',
      'type': 'Insurance',
      'size': '856 KB',
      'expiryDate': '2024-08-30',
      'isExpiring': false,
      'isExpired': true,
    },
  ];

  final List<Map<String, dynamic>> _mockTripDocuments = [
    {
      'title': 'Flight Ticket - Paris',
      'type': 'Ticket',
      'size': '1.2 MB',
      'expiryDate': null,
      'isExpiring': false,
      'isExpired': false,
    },
    {
      'title': 'Hotel Voucher - Rome',
      'type': 'Voucher',
      'size': '945 KB',
      'expiryDate': null,
      'isExpiring': false,
      'isExpired': false,
    },
    {
      'title': 'Schengen Visa',
      'type': 'Visa',
      'size': '1.6 MB',
      'expiryDate': '2025-06-10',
      'isExpiring': false,
      'isExpired': false,
    },
  ];
}