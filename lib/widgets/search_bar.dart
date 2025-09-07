import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';

class CustomSearchBar extends StatefulWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const CustomSearchBar({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Allow tapping anywhere on the container to focus the text field
        _focusNode.requestFocus();
      },
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
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search trips...',
            prefixIcon: Icon(Iconsax.search_normal_1),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
}
