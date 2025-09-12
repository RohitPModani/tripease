import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../models/location.dart';
import '../services/location_search_service.dart';
import '../themes/app_theme.dart';

class DestinationAutocomplete extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Function(LocationSuggestion?)? onLocationSelected;
  final String? errorText;
  final bool enabled;

  const DestinationAutocomplete({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.onLocationSelected,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<DestinationAutocomplete> createState() => _DestinationAutocompleteState();
}

class _DestinationAutocompleteState extends State<DestinationAutocomplete> {
  final LocationSearchService _locationService = LocationSearchService();
  final FocusNode _focusNode = FocusNode();
  
  List<LocationSuggestion> _suggestions = [];
  bool _isLoading = false;
  bool _showSuggestions = false;
  LocationSuggestion? _selectedLocation;
  
  // Debounce functionality
  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 300);
  static const int _minSearchLength = 2;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    // Keep internal selection state in sync with external text changes
    widget.controller.addListener(_onControllerChanged);
    _loadPopularDestinations();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    widget.controller.removeListener(_onControllerChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    // If the parent clears the text, clear selection and suggestions
    if (widget.controller.text.isEmpty && _selectedLocation != null) {
      setState(() {
        _selectedLocation = null;
        _showSuggestions = false;
      });
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && _suggestions.isNotEmpty) {
      setState(() {
        _showSuggestions = true;
      });
    } else if (!_focusNode.hasFocus) {
      // Delay hiding to allow for tap on suggestion
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() {
            _showSuggestions = false;
          });
        }
      });
    }
  }

  Future<void> _loadPopularDestinations() async {
    try {
      final popular = await _locationService.getPopularLocations(limit: 5);
      if (mounted && widget.controller.text.isEmpty) {
        setState(() {
          _suggestions = popular;
        });
      }
    } catch (e) {
      print('Error loading popular destinations: $e');
    }
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // If query is too short, show popular destinations immediately
    if (query.length < _minSearchLength) {
      _loadPopularDestinations();
      return;
    }
    
    // Start new timer for debounced search
    _debounceTimer = Timer(_debounceDuration, () {
      _searchLocations(query);
    });
  }

  Future<void> _searchLocations(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _locationService.searchLocations(query);
      if (mounted) {
        setState(() {
          _suggestions = results;
          _showSuggestions = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error searching locations: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _selectLocation(LocationSuggestion location) {
    setState(() {
      _selectedLocation = location;
      _showSuggestions = false;
    });
    
    widget.controller.text = location.shortDisplayName;
    widget.onLocationSelected?.call(location);
    _focusNode.unfocus();
  }

  void _clearSelection() {
    setState(() {
      _selectedLocation = null;
    });
    widget.onLocationSelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text field with search
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          enabled: widget.enabled,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText ?? 'Search destinations...',
            prefixIcon: Icon(
              Iconsax.location,
              color: _selectedLocation != null ? AppTheme.primaryColor : null,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isLoading)
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 8),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                if (_selectedLocation != null && widget.enabled)
                  IconButton(
                    icon: Icon(Iconsax.close_circle, size: 20),
                    onPressed: () {
                      widget.controller.clear();
                      _clearSelection();
                      _loadPopularDestinations();
                    },
                    color: AppTheme.textSecondary,
                  ),
              ],
            ),
            errorText: widget.errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _selectedLocation != null 
                    ? AppTheme.primaryColor.withOpacity(0.5)
                    : AppTheme.textSecondary.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
          ),
          onChanged: (value) {
            _clearSelection();
            _onSearchChanged(value);
          },
          onTap: () {
            if (_suggestions.isNotEmpty) {
              setState(() {
                _showSuggestions = true;
              });
            }
          },
        ),

        // Suggestions dropdown
        if (_showSuggestions && _suggestions.isNotEmpty && widget.enabled)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.surfaceDark
                  : AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header for popular destinations
                if (widget.controller.text.isEmpty && _suggestions.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.heart,
                          size: 16,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Popular Destinations',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Suggestions list
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _suggestions.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: AppTheme.textSecondary.withOpacity(0.1),
                  ),
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Iconsax.location,
                          size: 16,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      title: Text(
                        suggestion.shortDisplayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: suggestion.displayName != suggestion.shortDisplayName
                          ? Text(
                              suggestion.displayName,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      trailing: suggestion.searchCount > 1
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${suggestion.searchCount}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : null,
                      onTap: () => _selectLocation(suggestion),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

        // Selected location display
        if (_selectedLocation != null)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.tick_circle,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Destination',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _selectedLocation!.shortDisplayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
