import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    super.key,
    required this.isSearch,
    required this.searchController,
  });

  final bool isSearch;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),

      child: isSearch
          ? Padding(
              key: ValueKey('search'),

              padding: EdgeInsets.only(top: 4, bottom: 8),

              child: SizedBox(
                height: 48,

                child: TextFormField(
                  controller: searchController,

                  decoration: InputDecoration(
                    hintText: 'Search here......',

                    prefixIcon: Icon(Icons.search),

                    filled: true,

                    fillColor: Colors.grey.shade100,

                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 12,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),

                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(key: ValueKey('empty')),
    );
  }
}
