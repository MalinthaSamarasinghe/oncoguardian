import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
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
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Settings'),
            titleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 25, height: 1.41),
            leadingWidth: 83,
            titleSpacing: 2,
            leading: Center(
              child: AppIconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  GoRouter.of(context).pop();
                },
                backgroundColor: const Color(0xFFF3F4F6),
                iconWidget: SvgPicture.asset('assets/svg/back.svg', width: 24, height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Account',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, height: 1.68),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
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
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            context.push('/settings/edit-profile');
                          },
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
                                child: Center(child: SvgPicture.asset('assets/svg/settings_edit_profile.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Edit Profile',
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
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            context.push('/settings/account-settings');
                          },
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
                                child: Center(child: SvgPicture.asset('assets/svg/settings_account_settings.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Account Settings',
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
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Privacy & Support',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, height: 1.68),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
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
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
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
                                child: Center(child: SvgPicture.asset('assets/svg/settings_privacy_policy.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Privacy Policy',
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
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
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
                                child: Center(child: SvgPicture.asset('assets/svg/settings_help_support.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Help & Support',
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
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      context.read<AuthenticationBloc>().add(const UserLoggedOutEvent());
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
