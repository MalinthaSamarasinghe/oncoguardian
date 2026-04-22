import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oncoguardian/features/settings/widgets/settings_content_widgets.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          appBar: SettingsAppBar(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              GoRouter.of(context).pop();
            },
            title: 'Settings',
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  const SettingsTextHeadLine(text: 'Account'),
                  const SizedBox(height: 12),
                  SettingsContentCard(
                    onPressedFirst: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      context.push('/settings/edit-profile');
                    },
                    onPressedSecond: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      context.push('/settings/account-settings');
                    },
                    textFirst: 'Edit Profile',
                    textSecond: 'Account Settings',
                    textFirstIconAssetPath: 'assets/svg/settings_edit_profile.svg',
                    textSecondIconAssetPath: 'assets/svg/settings_account_settings.svg',
                  ),
                  const SizedBox(height: 24),
                  const SettingsTextHeadLine(text: 'Privacy & Support'),
                  const SizedBox(height: 12),
                  SettingsContentCard(
                    onPressedFirst: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    onPressedSecond: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    textFirst: 'Privacy Policy',
                    textSecond: 'Help & Support',
                    textFirstIconAssetPath: 'assets/svg/settings_privacy_policy.svg',
                    textSecondIconAssetPath: 'assets/svg/settings_help_support.svg',
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      context.read<AuthenticationBloc>().add(const SignOutEvent());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFF3F4F6), width: 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/logout.svg', colorFilter: const ColorFilter.mode(Color(0xFFEF4444), BlendMode.srcIn)),
                          const SizedBox(width: 8),
                          Text(
                            'Log Out',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: const Color(0xFFEF4444), height: 1.76),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
