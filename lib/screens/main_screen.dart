import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import 'trips_screen.dart';
import 'documents_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _fabAnimationController;

  final List<IconData> _icons = [
    Iconsax.map_1,
    Iconsax.document,
    Iconsax.setting_2,
  ];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    
    _screens = [
      const TripsScreen(),
      const DocumentsScreen(),
      const SettingsScreen(),
    ];

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animationController.forward();
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<String> _getTabTitles(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.trips,
      l10n.documents,
      l10n.settings,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabTitles = _getTabTitles(context);
    
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: _screens[_currentIndex],
              );
            },
          ),
          if (_currentIndex == 0)
            Positioned(
              right: 20,
              bottom: 100,
              child: ScaleTransition(
                scale: _fabAnimationController,
                child: Container(
                  decoration: AppTheme.glowingButtonDecoration,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create-trip');
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: const Icon(
                      Iconsax.add,
                      size: 28,
                      color: AppTheme.textLight,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
          boxShadow: [
            BoxShadow(
              color: isDark 
                  ? Colors.black.withOpacity(0.3)
                  : AppTheme.primaryColor.withOpacity(0.1),
              offset: const Offset(0, -4),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_icons.length, (index) {
                final isActive = _currentIndex == index;
                final color = isActive 
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabTapped(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: isActive
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _icons[index],
                                    size: 18,
                                    color: color,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      tabTitles[index],
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: color,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                _icons[index],
                                size: 24,
                                color: color,
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}