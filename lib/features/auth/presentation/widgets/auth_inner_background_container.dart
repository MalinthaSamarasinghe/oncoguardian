import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/core/widgets/app_logo.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_background_container.dart';

class AuthInnerBackgroundContainer extends StatelessWidget {
  final Widget body;
  final bool isTermConditionScreen;

  const AuthInnerBackgroundContainer({super.key, required this.body, this.isTermConditionScreen = false});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundContainer(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isTermConditionScreen)...[
            SizedBox(
              height: 187,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 57,
                    left: 26,
                    child: AppIconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        GoRouter.of(context).pop();
                      },
                      backgroundColor: const Color(0xFFFFFFFF),
                      iconWidget: SvgPicture.asset('assets/svg/back.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surface, BlendMode.srcIn)),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 38),
                      child: AppLogo(),
                    ),
                  ),
                ],
              ),
            ),
          ] else...[
            const SizedBox(height: 60),
            const AppLogo(),
            const SizedBox(height: 22),
          ],
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.6),
              ),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
