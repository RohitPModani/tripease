import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';

class HtmlContentModal extends StatelessWidget {
  final String title;
  final String htmlContent;
  final IconData icon;
  final String? supportEmail;
  final String? supportButtonLabel;

  const HtmlContentModal({
    super.key,
    required this.title,
    required this.htmlContent,
    required this.icon,
    this.supportEmail,
    this.supportButtonLabel,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String htmlContent,
    required IconData icon,
    String? supportEmail,
    String? supportButtonLabel,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => HtmlContentModal(
        title: title,
        htmlContent: htmlContent,
        icon: icon,
        supportEmail: supportEmail,
        supportButtonLabel: supportButtonLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
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
          // Handle bar
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
          
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
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
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Iconsax.close_circle),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Html(
                data: htmlContent,
                style: {
                  "body": Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
                  ),
                  "h1": Style(
                    fontSize: FontSize(24),
                    fontWeight: FontWeight.bold,
                    margin: Margins.only(bottom: 16),
                    color: Theme.of(context).textTheme.headlineLarge?.color,
                  ),
                  "h2": Style(
                    fontSize: FontSize(20),
                    fontWeight: FontWeight.w600,
                    margin: Margins.only(top: 24, bottom: 12),
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                  "h3": Style(
                    fontSize: FontSize(18),
                    fontWeight: FontWeight.w600,
                    margin: Margins.only(top: 20, bottom: 8),
                    color: Theme.of(context).textTheme.headlineSmall?.color,
                  ),
                  "p": Style(
                    margin: Margins.only(bottom: 12),
                    lineHeight: LineHeight.number(1.5),
                  ),
                  "ul": Style(
                    margin: Margins.only(bottom: 16),
                  ),
                  "li": Style(
                    margin: Margins.only(bottom: 4),
                    lineHeight: LineHeight.number(1.4),
                  ),
                  "strong": Style(
                    fontWeight: FontWeight.w600,
                  ),
                  "em": Style(
                    fontStyle: FontStyle.italic,
                  ),
                  "a": Style(
                    color: AppTheme.primaryColor,
                    textDecoration: TextDecoration.none,
                  ),
                  ".section": Style(
                    margin: Margins.only(bottom: 24),
                  ),
                  ".highlight": Style(
                    backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                    padding: HtmlPaddings.all(12),
                    margin: Margins.only(bottom: 16),
                  ),
                  ".contact-info": Style(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    padding: HtmlPaddings.all(16),
                    margin: Margins.only(top: 16),
                  ),
                },
              ),
            ),
          ),
          
          // Footer with actions
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                if (supportEmail != null) ...[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final mailto = Uri(
                          scheme: 'mailto',
                          path: supportEmail,
                          query: Uri(queryParameters: {
                            'subject': 'Voythrix Support',
                          }).query,
                        );
                        if (await canLaunchUrl(mailto)) {
                          await launchUrl(mailto, mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Iconsax.message_question),
                      label: Text(supportButtonLabel ?? 'Contact Support'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.6), width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.close,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
