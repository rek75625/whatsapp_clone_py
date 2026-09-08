import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_font_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';

class PageHeader extends StatelessWidget {
  final String pageTitle;
  final bool isSearch;
  final VoidCallback onPressed;

  const PageHeader({
    super.key,
    required this.pageTitle,
    required this.isSearch,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isSearch ? 'Search' : pageTitle,
          style: TextStyle(
            fontSize: AppFontSizing.fontHeadingLarge24,
            fontWeight: FontWeight.w800,
            color: blackColor(context).darkShade,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Transform.rotate(
            angle: isSearch ? pi * (90 / 360) : 0,
            child: Icon(
              isSearch ? Icons.add : Icons.search,
              size: AppFontSizing.fontHeadingLarge24,
              color: AppColors.greenColor,
            ),
          ),
        ),
      ],
    );
  }
}
