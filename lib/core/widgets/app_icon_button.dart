import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget iconWidget;
  final double? size;
  final Color? backgroundColor;
  final bool isLoading;
  final bool isDisabled;

  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.iconWidget,
    this.size = 46,
    this.backgroundColor,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isDisabled || isLoading) ? null : onPressed,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      child: Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : iconWidget,
        ),
      ),
    );
  }
}
