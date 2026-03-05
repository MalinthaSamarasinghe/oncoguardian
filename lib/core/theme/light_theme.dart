import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oncoguardian/core/theme/app_colors.dart';
import 'package:oncoguardian/core/theme/app_text_styles.dart';

class LightTheme {
  LightTheme._(); // Private constructor to prevent instantiation

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.lightTextPrimary),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.lightTextPrimary),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.lightTextPrimary),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.lightTextPrimary),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.lightTextPrimary),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.lightTextPrimary),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.lightTextPrimary),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.lightTextPrimary),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.lightTextPrimary),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.lightTextPrimary),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.lightTextSecondary),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.lightTextTertiary),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.lightTextPrimary),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightTextSecondary),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary),
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
      hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextTertiary),
      labelStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightTextPrimary,
      selectionColor: AppColors.lightTextPrimary.withValues(alpha: 0.3),
      selectionHandleColor: AppColors.lightTextPrimary,
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
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFFE91E8C),
        elevation: 0,
        side: const BorderSide(color: Color(0xFFE91E8C), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        textStyle: AppTextStyles.titleMedium.copyWith(fontSize: 12, color: const Color(0xFFE91E8C), height: 1),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: AppColors.lightTextPrimary,
        padding: const EdgeInsets.all(10),
        fixedSize: const Size(60, 60),
        iconSize: 32,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.lightTextPrimary),
      checkColor: WidgetStateProperty.all(const Color(0xFFFFFFFF)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: const BorderSide(width: 1, color: AppColors.lightTextPrimary),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashRadius: 0,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.lightTextTertiary,
      size: 24,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.lightTextSecondary,
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
      thumbColor: WidgetStateProperty.all(const Color(0xFFFFFFFF)),
      trackColor: WidgetStateProperty.all(const Color(0xFFEC4899)),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      trackOutlineWidth: WidgetStateProperty.all(0),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      padding: EdgeInsets.zero,
      splashRadius: 0,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      expandedAlignment: Alignment.centerLeft,
      clipBehavior: Clip.antiAlias,
      backgroundColor: const Color(0xFFFFFFFF),
      collapsedBackgroundColor: const Color(0xFFFFFFFF),
      iconColor: const Color(0xFF9CA3AF),
      collapsedIconColor: const Color(0xFF9CA3AF),
      textColor: const Color(0xFFEC4899),
      collapsedTextColor: const Color(0xFF111827),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(width: 1, color: Color(0xFFF3F4F6)),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(width: 1, color: Color(0xFFF3F4F6)),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: Color(0xFF1ed760),
      surface: Color(0xFF858585),
      outline: AppColors.lightTextTertiary,
      error: Color(0xFFF44336),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: AppColors.lightTextPrimary,
      onError: Color(0xFFFFFFFF),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.transparent,
    focusColor: Colors.transparent,
  );
}
