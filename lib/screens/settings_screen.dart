import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../providers/localization_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

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
          icon: Iconsax.cloud,
          title: l10n.backupAndSync,
          subtitle: l10n.manageYourDataBackup,
          onTap: () {
            // TODO: Implement backup settings
          },
        ),
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
            // TODO: Implement data export
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
            _showClearDataDialog();
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
            ...localizationProvider.supportedLocales.map((locale) {
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
                    localizationProvider.getLanguageDisplayName(locale),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
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

  void _showClearDataDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearAllData),
        content: Text(l10n.clearAllDataConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement clear all data
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.error,
            ),
            child: Text(l10n.clearAll),
          ),
        ],
      ),
    );
  }
}