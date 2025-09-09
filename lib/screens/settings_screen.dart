import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../providers/localization_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/trip_provider.dart';
import '../providers/todo_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/document_provider.dart';
import '../database/database.dart';
import '../services/export_service.dart';
import '../repositories/trip_repository.dart';
import '../repositories/todo_repository.dart';
import '../repositories/booking_repository.dart';
import '../repositories/expense_repository.dart';
import '../repositories/document_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _deleteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _deleteController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;
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
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildPreferencesSection(),
                    const SizedBox(height: 24),
                    _buildAppSection(),
                    const SizedBox(height: 24),
                    _buildAboutSection(),
                    const SizedBox(height: 24),
                    _buildDangerZoneSection(),
                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 80,
      floating: true,
      pinned: true,
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          AppLocalizations.of(context)!.settings,
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


  Widget _buildPreferencesSection() {
    final l10n = AppLocalizations.of(context)!;
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return _buildSection(
      title: l10n.preferences,
      children: [
        _buildSwitchTile(
          icon: Iconsax.moon,
          title: l10n.darkMode,
          subtitle: l10n.switchBetweenLightAndDarkTheme,
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleDarkMode();
          },
        ),
        _buildActionTile(
          icon: Iconsax.language_square,
          title: l10n.language,
          subtitle: localizationProvider.getLanguageNativeName(localizationProvider.currentLocale),
          onTap: () {
            _showLanguageSelector(context);
          },
        ),
      ],
    );
  }

  Widget _buildAppSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildSection(
      title: l10n.appSettings,
      children: [
        _buildActionTile(
          icon: Iconsax.import,
          title: l10n.importData,
          subtitle: l10n.importTripsFromOtherApps,
          onTap: () {
            // TODO: Implement data import
          },
        ),
        _buildActionTile(
          icon: Iconsax.export,
          title: l10n.exportData,
          subtitle: l10n.exportYourTripData,
          onTap: () {
            _showExportDialog();
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildSection(
      title: l10n.about,
      children: [
        _buildActionTile(
          icon: Iconsax.info_circle,
          title: l10n.appVersion,
          subtitle: AppLocalizations.of(context)!.appVersionBeta,
          onTap: null,
        ),
        _buildActionTile(
          icon: Iconsax.heart,
          title: l10n.rateApp,
          subtitle: l10n.leaveAReviewOnTheAppStore,
          onTap: () {
            // TODO: Open app store for rating
          },
        ),
        _buildActionTile(
          icon: Iconsax.message_question,
          title: l10n.helpAndSupport,
          subtitle: l10n.faqsAndContactInformation,
          onTap: () {
            // TODO: Open help section
          },
        ),
        _buildActionTile(
          icon: Iconsax.document_text,
          title: l10n.privacyPolicy,
          subtitle: l10n.readOurPrivacyPolicy,
          onTap: () {
            // TODO: Open privacy policy
          },
        ),
        _buildActionTile(
          icon: Iconsax.shield_tick,
          title: l10n.termsOfService,
          subtitle: l10n.readOurTermsAndConditions,
          onTap: () {
            // TODO: Open terms of service
          },
        ),
      ],
    );
  }

  Widget _buildDangerZoneSection() {
    final l10n = AppLocalizations.of(context)!;
    return _buildSection(
      title: l10n.dangerZone,
      children: [
        _buildActionTile(
          icon: Iconsax.trash,
          title: l10n.clearAllData,
          subtitle: l10n.removeAllTripsAndDocuments,
          onTap: () {
            _showFirstConfirmationDialog();
          },
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.pixieCardDecorationDark
              : AppTheme.pixieCardDecoration,
          child: Column(
            children: children.map((child) {
              final index = children.indexOf(child);
              return Column(
                children: [
                  child,
                  if (index < children.length - 1)
                    Divider(
                      height: 1,
                      color: AppTheme.textSecondary.withOpacity(0.1),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }


  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }


  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDestructive
              ? AppTheme.error.withOpacity(0.1)
              : AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isDestructive ? AppTheme.error : AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppTheme.error : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: onTap != null ? const Icon(
        Iconsax.arrow_right_3,
        color: AppTheme.textSecondary,
        size: 20,
      ) : null,
      onTap: onTap,
    );
  }

  void _showLanguageSelector(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;
    final localizationProvider = Provider.of<LocalizationProvider>(context, listen: false);
    
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
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: localizationProvider.supportedLocales.map((locale) {
              final isSelected = locale == localizationProvider.currentLocale;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected 
                      ? Border.all(color: AppTheme.primaryColor, width: 2)
                      : null,
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        _getLanguageFlag(locale.languageCode),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    _localizedLanguageName(context, locale),
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? AppTheme.primaryColor : null,
                    ),
                  ),
                  trailing: isSelected 
                      ? const Icon(
                          Iconsax.tick_circle,
                          color: AppTheme.primaryColor,
                        )
                      : null,
                  onTap: () {
                    localizationProvider.setLocale(locale);
                    Navigator.pop(context);
                  },
                ),
              );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _localizedLanguageName(BuildContext context, Locale locale) {
    final l = AppLocalizations.of(context)!;
    switch (locale.languageCode) {
      case 'en':
        return l.english;
      case 'zh':
        return l.mandarin;
      case 'ja':
        return l.japanese;
      case 'ko':
        return l.korean;
      case 'es':
        return l.spanish;
      case 'fr':
        return l.french;
      case 'de':
        return l.german;
      case 'it':
        return l.italian;
      case 'pt':
        return l.portuguese;
      case 'ru':
        return l.russian;
      case 'ar':
        return l.arabic;
      case 'hi':
        return l.hindi;
      case 'nl':
        return l.dutch;
      default:
        return l.english;
    }
  }

  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'zh':
        return '🇨🇳';
      case 'ja':
        return '🇯🇵';
      case 'ko':
        return '🇰🇷';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      case 'it':
        return '🇮🇹';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'ar':
        return '🇸🇦';
      case 'hi':
        return '🇮🇳';
      case 'nl':
        return '🇳🇱';
      default:
        return '🌍';
    }
  }

  void _showFirstConfirmationDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Iconsax.warning_2,
                color: AppTheme.error,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(l10n.clearAllData)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This action will permanently delete:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ..._buildDataList(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.error.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.info_circle,
                    color: AppTheme.error,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.confirmActionWarning,
                      style: TextStyle(
                        color: AppTheme.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSecondConfirmationDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(AppLocalizations.of(context)!.continueAction),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDataList() {
    final items = [
      '• All trips and itineraries',
      '• All tasks and todo items', 
      '• All bookings and reservations',
      '• All expenses and receipts',
      '• All documents and attachments',
      '• All app settings and preferences',
    ];
    
    return items.map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        item,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    )).toList();
  }

  void _showSecondConfirmationDialog() {
    final l10n = AppLocalizations.of(context)!;
    _deleteController.clear();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Iconsax.shield_cross,
                  color: AppTheme.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.finalConfirmationTitle,
                  style: TextStyle(
                    color: AppTheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.clearAllDataConfirmation,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.finalConfirmationPrompt('DELETE'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.error.withOpacity(0.5),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _deleteController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'DELETE',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: _deleteController.text.trim() == 'DELETE'
                  ? () async {
                      Navigator.pop(context);
                      await _performClearAllData();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.deleteEverything),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performClearAllData() async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.deletingAllData,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.pleaseWait,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

      // Clear database
      final database = AppDatabase();
      await database.clearDatabase();
      await database.close();
      
      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      // Reset providers to initial state
      if (mounted) {
        final tripProvider = Provider.of<TripProvider>(context, listen: false);
        final todoProvider = Provider.of<TodoProvider>(context, listen: false);
        final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
        final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
        final documentProvider = Provider.of<DocumentProvider>(context, listen: false);
        final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
        final localizationProvider = Provider.of<LocalizationProvider>(context, listen: false);
        
        // Reset providers
        await tripProvider.loadTrips();
        await documentProvider.loadPersonalDocuments();
        
        // Reset theme and language to defaults
        themeProvider.toggleDarkMode(); // This will reset to system preference
        localizationProvider.setLocale(const Locale('en'));
      }
      
      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);
        
        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Iconsax.tick_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)!.dataClearedTitle),
              ],
            ),
            content: Text(AppLocalizations.of(context)!.dataClearedMessage),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if open
      if (mounted) Navigator.pop(context);
      
      // Show error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Iconsax.warning_2,
                    color: AppTheme.error,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)!.errorTitle),
              ],
            ),
            content: Text(AppLocalizations.of(context)!.failedToClearAllData(e.toString())),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.error,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showExportDialog() {
    final l10n = AppLocalizations.of(context)!;
    _passwordController.clear();
    _confirmPasswordController.clear();
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Iconsax.export,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(l10n.exportData)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.exportIntroTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ..._buildExportDataList(),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.accentColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.shield_tick,
                        color: AppTheme.accentColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.exportEncryptionInfo,
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.backupPasswordTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.exportEncryptionInfo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.backupPasswordHint,
                    prefixIcon: const Icon(Iconsax.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                if (_passwordController.text.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                      prefixIcon: const Icon(Iconsax.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Iconsax.eye_slash : Iconsax.eye,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _passwordsMatch() ? Colors.green : AppTheme.error,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _passwordsMatch() ? Colors.green : AppTheme.error,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        _passwordsMatch() ? Iconsax.tick_circle : Iconsax.close_circle,
                        size: 16,
                        color: _passwordsMatch() ? Colors.green : AppTheme.error,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _passwordsMatch() ? AppLocalizations.of(context)!.passwordsMatch : AppLocalizations.of(context)!.passwordsDoNotMatch,
                        style: TextStyle(
                          fontSize: 12,
                          color: _passwordsMatch() ? Colors.green : AppTheme.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: _canExport() ? () => _performExport() : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Iconsax.export, size: 16),
                  const SizedBox(width: 6),
                  Text(AppLocalizations.of(context)!.createBackup),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildExportDataList() {
    final items = [
      '• All trips and itineraries',
      '• All tasks and todo items', 
      '• All bookings and reservations',
      '• All expenses and receipts',
      '• All documents and attachments',
      '• All app settings and preferences',
    ];
    
    return items.map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        item,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    )).toList();
  }

  bool _passwordsMatch() {
    return _passwordController.text.isEmpty || 
           _passwordController.text == _confirmPasswordController.text;
  }

  bool _canExport() {
    if (_passwordController.text.isEmpty) return true;
    return _passwordController.text.isNotEmpty && _passwordsMatch();
  }

  Future<void> _performExport() async {
    try {
      Navigator.pop(context); // Close export dialog
      
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.creatingBackup,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.collectingAndEncrypting,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

      // Get repositories from providers
      final tripProvider = Provider.of<TripProvider>(context, listen: false);
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
      final documentProvider = Provider.of<DocumentProvider>(context, listen: false);
      
      // Create export
      final password = _passwordController.text.isEmpty ? null : _passwordController.text;
      final filePath = await ExportService.exportAllData(
        tripRepository: tripProvider.tripRepository,
        todoRepository: todoProvider.todoRepository,
        bookingRepository: bookingProvider.bookingRepository,
        expenseRepository: expenseProvider.expenseRepository,
        documentRepository: documentProvider.documentRepository,
        password: password,
      );
      
      // Close loading dialog
      if (mounted) Navigator.pop(context);
      
      // Show success dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Iconsax.tick_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)!.backupCreatedTitle),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.backupCreatedMessage,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.fileInfoLabel,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppLocalizations.of(context)!.fileInfoFormat,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        password != null ? AppLocalizations.of(context)!.fileInfoSecurityPassword : AppLocalizations.of(context)!.fileInfoSecurityStandard,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        AppLocalizations.of(context)!.fileInfoCompression,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context)!.keepFileSafeNote,
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  await ExportService.shareExportFile(filePath);
                },
                icon: const Icon(Iconsax.share, size: 16),
                label: Text(AppLocalizations.of(context)!.share),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if open
      if (mounted) Navigator.pop(context);
      
      // Show error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Iconsax.warning_2,
                    color: AppTheme.error,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)!.exportFailedTitle),
              ],
            ),
            content: Text(AppLocalizations.of(context)!.failedToCreateBackup(e.toString())),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.error,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      }
    }
  }
}
