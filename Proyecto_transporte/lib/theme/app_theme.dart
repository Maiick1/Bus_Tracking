import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
/// Implements Contemporary Transit Minimalism design with Urban Night Navigation color scheme.
class AppTheme {
  AppTheme._();

  // Urban Night Navigation Color Palette
  static const Color primaryNavy = Color(0xFF1a1a2e);
  static const Color surfaceWhite = Color(0xFFffffff);
  static const Color successGreen = Color(0xFF00c851);
  static const Color warningAmber = Color(0xFFffbb33);
  static const Color errorRed = Color(0xFFff4444);
  static const Color infoBlue = Color(0xFF33b5e5);
  static const Color neutralGray = Color(0xFF6c757d);
  static const Color borderSubtle = Color(0xFF2d2d44);
  static const Color accentTeal = Color(0xFF20c997);
  static const Color backgroundSecondary = Color(0xFF252547);

  // Light theme variations (for system compatibility)
  static const Color primaryLight = Color(0xFF1a1a2e);
  static const Color backgroundLight = Color(0xFFffffff);
  static const Color surfaceLight = Color(0xFFf8f9fa);
  static const Color onPrimaryLight = Color(0xFFffffff);
  static const Color onBackgroundLight = Color(0xFF1a1a2e);
  static const Color onSurfaceLight = Color(0xFF1a1a2e);

  // Dark theme (primary theme for transit app)
  static const Color primaryDark = Color(0xFF1a1a2e);
  static const Color backgroundDark = Color(0xFF1a1a2e);
  static const Color surfaceDark = Color(0xFF252547);
  static const Color onPrimaryDark = Color(0xFFffffff);
  static const Color onBackgroundDark = Color(0xFFffffff);
  static const Color onSurfaceDark = Color(0xFFffffff);

  // Text emphasis levels for accessibility
  static const Color textHighEmphasisLight = Color(0xDE1a1a2e); // 87% opacity
  static const Color textMediumEmphasisLight = Color(0x991a1a2e); // 60% opacity
  static const Color textDisabledLight = Color(0x611a1a2e); // 38% opacity

  static const Color textHighEmphasisDark = Color(0xDEffffff); // 87% opacity
  static const Color textMediumEmphasisDark = Color(0x99ffffff); // 60% opacity
  static const Color textDisabledDark = Color(0x61ffffff); // 38% opacity

  /// Light theme for system compatibility
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: backgroundSecondary,
      onPrimaryContainer: surfaceWhite,
      secondary: accentTeal,
      onSecondary: primaryNavy,
      secondaryContainer: accentTeal.withValues(alpha: 0.1),
      onSecondaryContainer: primaryNavy,
      tertiary: infoBlue,
      onTertiary: surfaceWhite,
      tertiaryContainer: infoBlue.withValues(alpha: 0.1),
      onTertiaryContainer: primaryNavy,
      error: errorRed,
      onError: surfaceWhite,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      onSurfaceVariant: neutralGray,
      outline: borderSubtle,
      outlineVariant: borderSubtle.withValues(alpha: 0.5),
      shadow: primaryNavy.withValues(alpha: 0.1),
      scrim: primaryNavy.withValues(alpha: 0.5),
      inverseSurface: primaryNavy,
      onInverseSurface: surfaceWhite,
      inversePrimary: accentTeal,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: surfaceWhite,
    dividerColor: borderSubtle.withValues(alpha: 0.2),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: onPrimaryLight,
      elevation: 1.0,
      shadowColor: primaryNavy.withValues(alpha: 0.1),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onPrimaryLight,
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: onPrimaryLight,
        size: 24,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceWhite,
      elevation: 2.0,
      shadowColor: primaryNavy.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceWhite,
      selectedItemColor: primaryLight,
      unselectedItemColor: neutralGray,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentTeal,
      foregroundColor: surfaceWhite,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: surfaceWhite,
        backgroundColor: primaryLight,
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: borderSubtle, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceWhite,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderSubtle.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderSubtle.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutralGray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal;
        }
        return neutralGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal.withValues(alpha: 0.3);
        }
        return neutralGray.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(surfaceWhite),
      side: const BorderSide(color: borderSubtle, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal;
        }
        return neutralGray;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentTeal,
      linearTrackColor: borderSubtle,
      circularTrackColor: borderSubtle,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: accentTeal,
      thumbColor: accentTeal,
      overlayColor: accentTeal.withValues(alpha: 0.2),
      inactiveTrackColor: borderSubtle,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryLight,
      unselectedLabelColor: neutralGray,
      indicatorColor: accentTeal,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryNavy.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: surfaceWhite,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryNavy,
      contentTextStyle: GoogleFonts.inter(
        color: surfaceWhite,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentTeal,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceWhite),
  );

  /// Dark theme - Primary theme optimized for transit usage
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryNavy,
      onPrimary: onPrimaryDark,
      primaryContainer: backgroundSecondary,
      onPrimaryContainer: surfaceWhite,
      secondary: accentTeal,
      onSecondary: primaryNavy,
      secondaryContainer: accentTeal.withValues(alpha: 0.2),
      onSecondaryContainer: surfaceWhite,
      tertiary: infoBlue,
      onTertiary: surfaceWhite,
      tertiaryContainer: infoBlue.withValues(alpha: 0.2),
      onTertiaryContainer: surfaceWhite,
      error: errorRed,
      onError: surfaceWhite,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: neutralGray,
      outline: borderSubtle,
      outlineVariant: borderSubtle.withValues(alpha: 0.5),
      shadow: Colors.black.withValues(alpha: 0.2),
      scrim: Colors.black.withValues(alpha: 0.5),
      inverseSurface: surfaceWhite,
      onInverseSurface: primaryNavy,
      inversePrimary: accentTeal,
    ),
    scaffoldBackgroundColor: primaryNavy,
    cardColor: backgroundSecondary,
    dividerColor: borderSubtle,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryNavy,
      foregroundColor: surfaceWhite,
      elevation: 1.0,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: surfaceWhite,
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: surfaceWhite,
        size: 24,
      ),
    ),
    cardTheme: CardTheme(
      color: backgroundSecondary,
      elevation: 2.0,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundSecondary,
      selectedItemColor: accentTeal,
      unselectedItemColor: neutralGray,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentTeal,
      foregroundColor: surfaceWhite,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: surfaceWhite,
        backgroundColor: accentTeal,
        elevation: 2.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentTeal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: borderSubtle, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentTeal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: backgroundSecondary,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderSubtle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentTeal, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutralGray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal;
        }
        return neutralGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal.withValues(alpha: 0.3);
        }
        return neutralGray.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(surfaceWhite),
      side: const BorderSide(color: borderSubtle, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentTeal;
        }
        return neutralGray;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentTeal,
      linearTrackColor: borderSubtle,
      circularTrackColor: borderSubtle,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: accentTeal,
      thumbColor: accentTeal,
      overlayColor: accentTeal.withValues(alpha: 0.2),
      inactiveTrackColor: borderSubtle,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: surfaceWhite,
      unselectedLabelColor: neutralGray,
      indicatorColor: accentTeal,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceWhite.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: primaryNavy,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: backgroundSecondary,
      contentTextStyle: GoogleFonts.inter(
        color: surfaceWhite,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentTeal,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: backgroundSecondary),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    final Color textMediumEmphasis =
        isLight ? textMediumEmphasisLight : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      // Display styles - Inter for headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles - Inter with increased weights
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles - Inter medium weights
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles - Inter for readability
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles - Inter for UI elements
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textDisabled,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Status colors for transit-specific states
  static const Color onTimeGreen = successGreen;
  static const Color delayedAmber = warningAmber;
  static const Color cancelledRed = errorRed;
  static const Color trackingBlue = infoBlue;

  /// Semantic colors for payment and validation
  static const Color validatedSuccess = successGreen;
  static const Color paymentError = errorRed;
  static const Color processingInfo = infoBlue;
  static const Color expiredWarning = warningAmber;
}
