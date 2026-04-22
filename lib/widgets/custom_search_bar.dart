import 'package:crypto_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;

  const CustomSearchBar({
    required this.onSearch,
    this.hintText = 'Search crypto...',
    super.key,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search, color: AppColors.primary, size: 24),
          ),

          // TextField
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.onSearch(value);
                }
              },
            ),
          ),

          // Clear Button
          if (_controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                _controller.clear();
                setState(() {});
              },
              icon: Icon(Icons.close, color: AppColors.textSecondary),
            ),

          // Search Button
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onSearch(_controller.text);
                }
              },
              icon: Icon(Icons.arrow_forward, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
