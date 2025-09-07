import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import '../models/attachment.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';

class DocumentViewer extends StatelessWidget {
  final BookingAttachment attachment;

  const DocumentViewer({
    super.key,
    required this.attachment,
  });

  static void show(BuildContext context, BookingAttachment attachment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DocumentViewer(attachment: attachment),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  attachment.isPdf ? Iconsax.document_text :
                  attachment.isImage ? Iconsax.image :
                  Iconsax.document,
                  color: AppTheme.primaryColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attachment.fileName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${attachment.displaySize} • ${attachment.mimeType}',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _downloadAttachment(context),
                      icon: Icon(
                        Iconsax.document_download,
                        color: AppTheme.secondaryColor,
                        size: 28,
                      ),
                      tooltip: AppLocalizations.of(context)!.download,
                    ),
                    IconButton(
                      onPressed: () => _shareAttachment(context),
                      icon: Icon(
                        Iconsax.share,
                        color: AppTheme.primaryColor,
                        size: 28,
                      ),
                      tooltip: AppLocalizations.of(context)!.share,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Iconsax.close_circle,
                        color: AppTheme.textSecondary,
                        size: 28,
                      ),
                      tooltip: AppLocalizations.of(context)!.close,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final file = File(attachment.filePath);
    
    return FutureBuilder<bool>(
      future: file.exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }
        
        if (!snapshot.hasData || !snapshot.data!) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.document,
                  size: 80,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.fileNotFound,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.fileMovedOrDeleted,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        if (attachment.isImage) {
          return _buildImageViewer();
        } else if (attachment.isPdf) {
          return _buildPdfViewer();
        } else {
          return _buildDocumentPlaceholder(context);
        }
      },
    );
  }

  Widget _buildImageViewer() {
    return InteractiveViewer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.file(
          File(attachment.filePath),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.image,
                    size: 80,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.cannotDisplayImage,
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPdfViewer() {
    return PDFView(
      filePath: attachment.filePath,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: true,
      pageSnap: true,
      defaultPage: 0,
      fitPolicy: FitPolicy.BOTH,
      preventLinkNavigation: false,
      onError: (error) {
        print('PDF Error: $error');
      },
      onPageError: (page, error) {
        print('PDF Page Error: $page - $error');
      },
    );
  }

  Widget _buildDocumentPlaceholder(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                attachment.isPdf ? Iconsax.document_text : Iconsax.document,
                size: 60,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              attachment.fileName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              '${attachment.displaySize} • ${attachment.fileExtension.toUpperCase()}',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.previewNotAvailable,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: AppTheme.glowingButtonDecoration,
                  child: ElevatedButton.icon(
                    onPressed: () => _openExternally(context),
                    icon: const Icon(Iconsax.export),
                    label: Text(AppLocalizations.of(context)!.openExternally),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _downloadAttachment(context),
                  icon: const Icon(Iconsax.document_download),
                  label: Text(AppLocalizations.of(context)!.download),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadAttachment(BuildContext context) async {
    try {
      final file = File(attachment.filePath);
      if (!await file.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.fileNotFound),
            backgroundColor: AppTheme.error,
          ),
        );
        return;
      }

      // Use Share.shareXFiles which will allow user to save to Downloads or other apps
      await Share.shareXFiles(
        [XFile(attachment.filePath)],
        subject: 'Save ${attachment.fileName}',
        text: 'Save this document to your device',
      );

      // Show confirmation that download/share was initiated
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File ready to download - choose where to save it'),
          backgroundColor: AppTheme.success,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error preparing download: $e'),
          backgroundColor: AppTheme.error,
        ),
      );
    }
  }

  Future<void> _shareAttachment(BuildContext context) async {
    try {
      final file = File(attachment.filePath);
      if (await file.exists()) {
        await Share.shareXFiles(
          [XFile(attachment.filePath)],
          subject: attachment.fileName,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.fileNotFound),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorSharingFile(e.toString())),
          backgroundColor: AppTheme.error,
        ),
      );
    }
  }

  Future<void> _openExternally([BuildContext? ctx]) async {
    try {
      final file = File(attachment.filePath);
      if (await file.exists()) {
        await _openFile(attachment.filePath);
      }
    } catch (e) {
      // Fallback to sharing if opening externally fails
      if (ctx != null) {
        _shareAttachment(ctx);
      }
    }
  }

  Future<void> _openFile(String filePath) async {
    final uri = Uri.file(filePath);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Cannot open file');
    }
  }
}