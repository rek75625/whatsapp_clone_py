import 'package:flutter/material.dart';

/// A centralized class for managing type scaling and consistent text sizes.
class AppFontSizing {
  AppFontSizing._(); // Prevent instantiation

  // ===========================================================================
  // 1. RAW FONT SIZES (Scale values)
  // ===========================================================================
  static const double fontDisplayLarge40 = 40.0;
  static const double fontDisplayMedium32 = 32.0;
  static const double fontHeadingLarge24 = 24.0;
  static const double fontHeadingMedium20 = 20.0;
  static const double fontHeadingSmall18 = 18.0;
  static const double fontBodyLarge16 = 16.0;
  static const double fontBodyMedium14 = 14.0;
  static const double fontBodySmall12 = 12.0;
  static const double fontCaption10 = 10.0;

  // ===========================================================================
  // 2. LINE HEIGHT MULTIPLIERS (Crucial for crisp multi-line text alignment)
  // ===========================================================================
  static const double heightsDisplay11 =
      1.1; // Tighter line space for massive sizes
  static const double heightsHeading125 = 1.25;
  static const double heightsBody15 =
      1.5; // Higher line space for body readability
  static const double heightsCaption14 = 1.4;

  // ===========================================================================
  // 3. READY-TO-USE TYPOGRAPHY STYLES
  // ===========================================================================

  // --- Displays (For splash screens, landing highlights) ---
  static const TextStyle displayLarge = TextStyle(
    fontSize: fontDisplayLarge40,
    height: heightsDisplay11,
  );
  static const TextStyle displayMedium = TextStyle(
    fontSize: fontDisplayMedium32,
    height: heightsDisplay11,
  );

  // --- Headings (For titles and section headers) ---
  static const TextStyle headingLarge = TextStyle(
    fontSize: fontHeadingLarge24,
    height: heightsHeading125,
  );
  static const TextStyle headingMedium = TextStyle(
    fontSize: fontHeadingMedium20,
    height: heightsHeading125,
  );
  static const TextStyle headingSmall = TextStyle(
    fontSize: fontHeadingSmall18,
    height: heightsHeading125,
  );

  // --- Body Text (For UI controls, fields, paragraphs) ---
  static const TextStyle bodyLarge = TextStyle(
    fontSize: fontBodyLarge16,
    height: heightsBody15,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: fontBodyMedium14,
    height: heightsBody15,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: fontBodySmall12,
    height: heightsBody15,
  );

  // --- Metadata & Tiny Labels ---
  static const TextStyle caption = TextStyle(
    fontSize: fontCaption10,
    height: heightsCaption14,
  );
}
