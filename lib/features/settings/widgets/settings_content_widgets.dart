import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';

class SettingsTextHeadLine extends StatelessWidget {
  final String text;

  const SettingsTextHeadLine({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, height: 1.68),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          maxLines: 1,
        ),
      ),
    );
  }
}

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final String title;

  const SettingsAppBar({super.key, required this.onPressed, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 25, height: 1.41),
      leadingWidth: 83,
      titleSpacing: 2,
      leading: Center(
        child: AppIconButton(
          onPressed: onPressed,
          backgroundColor: const Color(0xFFF3F4F6),
          iconWidget: SvgPicture.asset('assets/svg/back.svg', width: 24, height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
        ),
      ),
    );
  }
}

class SettingsContentCard extends StatelessWidget {
  final VoidCallback onPressedFirst;
  final VoidCallback onPressedSecond;
  final String textFirst;
  final String textSecond;
  final String textFirstIconAssetPath;
  final String textSecondIconAssetPath;

  const SettingsContentCard({
    super.key,
    required this.onPressedFirst,
    required this.onPressedSecond,
    required this.textFirst,
    required this.textSecond,
    required this.textFirstIconAssetPath,
    required this.textSecondIconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 137,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F4F6),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFF3F4F6), width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          GestureDetector(
            onTap: onPressedFirst,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF000000),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                  ),
                  child: Center(child: SvgPicture.asset(textFirstIconAssetPath, colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    textFirst,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.76),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset('assets/svg/right_arrow.svg', colorFilter: const ColorFilter.mode(Color(0xFF000000), BlendMode.srcIn)),
                const SizedBox(width: 47),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(width: double.infinity, height: 1, color: const Color(0xFFFFFFFF)),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: onPressedSecond,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF000000),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                  ),
                  child: Center(child: SvgPicture.asset(textSecondIconAssetPath, colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    textSecond,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.76),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset('assets/svg/right_arrow.svg', colorFilter: const ColorFilter.mode(Color(0xFF000000), BlendMode.srcIn)),
                const SizedBox(width: 47),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
