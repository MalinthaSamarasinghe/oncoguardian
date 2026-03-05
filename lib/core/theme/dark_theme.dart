import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oncoguardian/core/theme/app_colors.dart';
import 'package:oncoguardian/core/theme/app_text_styles.dart';

class DarkTheme {
  DarkTheme._(); // Private constructor to prevent instantiation

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.darkTextPrimary),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.darkTextPrimary),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.darkTextPrimary),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.darkTextPrimary),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.darkTextPrimary),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.darkTextPrimary),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.darkTextPrimary),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.darkTextPrimary),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.darkTextPrimary),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.darkTextPrimary),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.darkTextSecondary),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.darkTextTertiary),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.darkTextPrimary),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkTextSecondary),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.darkTextSecondary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
      constraints: const BoxConstraints(minHeight: 40, maxHeight: 40),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      outlineBorder: const BorderSide(style: BorderStyle.none),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFFFFF)),
      ),
      hintStyle: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF858585)),
      labelStyle: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF525252)),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xFF242424),
      selectionColor: const Color(0xFF242424).withValues(alpha: 0.3),
      selectionHandleColor: const Color(0xFF242424),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        textStyle: AppTextStyles.titleMedium.copyWith(color: const Color(0xFFFFFFFF), height: 1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        side: const BorderSide(color: Color(0xFFFFFFFF), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        textStyle: AppTextStyles.titleMedium.copyWith(fontSize: 12, color: const Color(0xFFFFFFFF), height: 1),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF000000),
        padding: const EdgeInsets.all(10),
        fixedSize: const Size(60, 60),
        iconSize: 32,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(const Color(0xFFFFFFFF)),
      checkColor: WidgetStateProperty.all(const Color(0xFF242424)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: const BorderSide(width: 1, color: Color(0xFFFFFFFF)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashRadius: 0,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkTextTertiary,
      size: 24,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkTextSecondary,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 16,
      leadingWidth: 16,
      centerTitle: false,
      titleTextStyle: AppTextStyles.headlineSmall.copyWith(color: const Color(0xFF000000)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: const Color(0xFF000000),
      unselectedItemColor: const Color(0xFFB3B3B3),
      selectedLabelStyle: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF000000)),
      unselectedLabelStyle: AppTextStyles.labelSmall.copyWith(color: const Color(0xFFB3B3B3)),
    ),
    switchTheme: SwitchThemeData(
      thumbIcon: WidgetStateProperty.all(const Icon(null)),
      thumbColor: WidgetStateProperty.all(const Color(0xFFF829A7)),
      trackColor: WidgetStateProperty.all(const Color(0xFFFFFFFF)),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      trackOutlineWidth: WidgetStateProperty.all(0),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      padding: EdgeInsets.zero,
      splashRadius: 0,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      expandedAlignment: Alignment.centerLeft,
      clipBehavior: Clip.antiAlias,
      backgroundColor: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
      collapsedBackgroundColor: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
      iconColor: const Color(0xFFFFFFFF),
      collapsedIconColor: const Color(0xFFFFFFFF),
      textColor: const Color(0xFFEC4899),
      collapsedTextColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(width: 1, color: Color(0xFFFFFFFF)),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(width: 1, color: Color(0xFFFFFFFF)),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: Color(0xFF1ed760),
      surface: Color(0xFF121212),
      outline: AppColors.darkTextTertiary,
      error: Color(0xFFF44336),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: AppColors.darkTextPrimary,
      onSurface: Color(0xFFFFFFFF),
      onError: Color(0xFFFFFFFF),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.transparent,
    focusColor: Colors.transparent,
  );
}
