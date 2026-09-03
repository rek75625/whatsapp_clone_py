import 'package:flutter/material.dart';

/// A centralized class for managing consistent spacing, sizes, and paddings.
/// This prevents hardcoded numbers throughout your codebase.
class AppSizes {
  AppSizes._(); // Prevent instantiation

  // ===========================================================================
  // 1. RAW SIZE VALUES (For custom implementations or dimensions)
  // ===========================================================================
  static const double size4 = 4.0;
  static const double size8 = 8.0;
  static const double size12 = 12.0;
  static const double size16 = 16.0;
  static const double size24 = 24.0;
  static const double size32 = 32.0;
  static const double size48 = 48.0;
  static const double size64 = 64.0;

  // ===========================================================================
  // 2. FIXED SIZEBOXES (For gaps between widgets inside Rows/Columns)
  // ===========================================================================

  // --- Vertical Gaps (Heights) ---
  static const SizedBox height4 = SizedBox(height: size4);
  static const SizedBox height8 = SizedBox(height: size8);
  static const SizedBox height12 = SizedBox(height: size12);
  static const SizedBox height16 = SizedBox(height: size16);
  static const SizedBox height24 = SizedBox(height: size24);
  static const SizedBox height32 = SizedBox(height: size32);
  static const SizedBox height48 = SizedBox(height: size48);
  static const SizedBox height64 = SizedBox(height: size64);

  // --- Horizontal Gaps (Widths) ---
  static const SizedBox width4 = SizedBox(width: size4);
  static const SizedBox width8 = SizedBox(width: size8);
  static const SizedBox width12 = SizedBox(width: size12);
  static const SizedBox width16 = SizedBox(width: size16);
  static const SizedBox width24 = SizedBox(width: size24);
  static const SizedBox width32 = SizedBox(width: size32);
  static const SizedBox width48 = SizedBox(width: size48);
  static const SizedBox width64 = SizedBox(width: size64);

  // ===========================================================================
  // 3. PADDINGS (EdgeInsets)
  // ===========================================================================

  // --- Uniform Padding (All Sides Equal) ---
  static const EdgeInsets padAll4 = EdgeInsets.all(size4);
  static const EdgeInsets padAll8 = EdgeInsets.all(size8);
  static const EdgeInsets padAll12 = EdgeInsets.all(size12);
  static const EdgeInsets padAll16 = EdgeInsets.all(size16);
  static const EdgeInsets padAll24 = EdgeInsets.all(size24);
  static const EdgeInsets padAll32 = EdgeInsets.all(size32);

  // --- Symmetric Horizontal Padding ---
  static const EdgeInsets padHori4 = EdgeInsets.symmetric(horizontal: size4);
  static const EdgeInsets padHori8 = EdgeInsets.symmetric(horizontal: size8);
  static const EdgeInsets padHori12 = EdgeInsets.symmetric(horizontal: size12);
  static const EdgeInsets padHori16 = EdgeInsets.symmetric(horizontal: size16);
  static const EdgeInsets padHori24 = EdgeInsets.symmetric(horizontal: size24);
  static const EdgeInsets padHori32 = EdgeInsets.symmetric(horizontal: size32);

  // --- Symmetric Vertical Padding ---
  static const EdgeInsets padVert4 = EdgeInsets.symmetric(vertical: size4);
  static const EdgeInsets padVert8 = EdgeInsets.symmetric(vertical: size8);
  static const EdgeInsets padVert12 = EdgeInsets.symmetric(vertical: size12);
  static const EdgeInsets padVert16 = EdgeInsets.symmetric(vertical: size16);
  static const EdgeInsets padVert24 = EdgeInsets.symmetric(vertical: size24);
  static const EdgeInsets padVert32 = EdgeInsets.symmetric(vertical: size32);

  // --- Commonly Used Mixed Layout Saddings ---
  /// Layout padding often used for Screen Body structures (Left/Right: 16, Top/Bottom: 24)
  static const EdgeInsets padScreen = EdgeInsets.symmetric(
    horizontal: size16,
    vertical: size24,
  );

  /// Layout padding often used for Cards (Horizontal: 16, Vertical: 12)
  static const EdgeInsets padCard = EdgeInsets.symmetric(
    horizontal: size16,
    vertical: size12,
  );

  /// Layout padding often used for List Items (Horizontal: 16, Vertical: 8)
  static const EdgeInsets padListItem = EdgeInsets.symmetric(
    horizontal: size16,
    vertical: size8,
  );
}
