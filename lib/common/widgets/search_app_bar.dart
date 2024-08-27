import 'dart:async';

import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onCloseIconClicked;
  final ValueChanged<String> onInputValueChange;

  const SearchAppBar({
    super.key,
    required this.onCloseIconClicked,
    required this.onInputValueChange,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  TextEditingController? searchController;
  Timer? debounce;

  @override
  void dispose() {
    searchController?.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: TextField(
            autofocus: true,
            controller: searchController,
            onChanged: widget.onInputValueChange,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  searchController?.clear();
                  widget.onCloseIconClicked();
                },
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
      ],
    );
  }
}
