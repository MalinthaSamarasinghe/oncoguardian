import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/core/extensions/context_extensions.dart';
import 'package:oncoguardian/features/settings/widgets/account_settings_text_field.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;
  late final FocusNode _currentPasswordFocusNode;
  late final FocusNode _newPasswordFocusNode;
  late final FocusNode _confirmNewPasswordFocusNode;
  bool twoFactorAuthEnabled = false;
  bool pushNotificationsEnabled = false;
  bool smsAlertsEnabled = false;
  bool emailNewsletterEnabled = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    _currentPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordFocusNode.dispose();
    super.dispose();
  }

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
            title: const Text('Account Settings'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20, height: 0.8),
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Security',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(height: 1.67),
                  ),
                ),
                const SizedBox(height: 13),
                Container(
                  width: double.infinity,
                  height: 353,
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
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF000000),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: SvgPicture.asset('assets/svg/lock.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Change Password',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.71),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 81,
                            height: 29,
                            child: ElevatedButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  context.showSuccessSnackBar('Your password has been updated successfully!');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF000000),
                                  foregroundColor: const Color(0xFFFFFFFF),
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Color(0xFF000000), width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(height: 1),
                                ),
                              child: const Text('Update')
                            ),
                          ),
                          const SizedBox(width: 19),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Current Password',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, height: 1.8),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AccountSettingsTextField(
                        hint: 'Enter your current password',
                        controller: _currentPasswordController,
                        focusNode: _currentPasswordFocusNode,
                        isEnabled: true,
                        isObscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        textInputAction: TextInputAction.next,
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        onFieldSubmitted: (_) => _newPasswordFocusNode.requestFocus(),
                        validator: (_) => null,
                      ),
                      const SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'New Password',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, height: 1.8),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AccountSettingsTextField(
                        hint: 'Enter your new password',
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocusNode,
                        isEnabled: true,
                        isObscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        textInputAction: TextInputAction.next,
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        onFieldSubmitted: (_) => _confirmNewPasswordFocusNode.requestFocus(),
                        validator: (_) => null,
                      ),
                      const SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Confirm Password',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, height: 1.8),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AccountSettingsTextField(
                        hint: 'Confirm your new password',
                        controller: _confirmNewPasswordController,
                        focusNode: _confirmNewPasswordFocusNode,
                        isEnabled: true,
                        isObscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        textInputAction: TextInputAction.done,
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        onFieldSubmitted: (_) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        validator: (_) => null,
                      ),
                      const SizedBox(height: 19),
                      Container(width: double.infinity, height: 1, color: const Color(0xFFFFFFFF)),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF000000),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: SvgPicture.asset('assets/svg/shield.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Two-Factor Auth',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  'Recommended',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, height: 1.8),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 48,
                            height: 28,
                            child: Switch(
                              value: twoFactorAuthEnabled,
                              onChanged: (bool value) => setState(() => twoFactorAuthEnabled = value),
                              activeThumbColor: const Color(0xFFFFFFFF),
                              activeTrackColor: const Color(0xFF000000),
                              inactiveThumbColor: const Color(0xFFFFFFFF),
                              inactiveTrackColor: const Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(width: 19),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(height: 1.67),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 196,
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
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF000000),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: SvgPicture.asset('assets/svg/notification.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Push Notifications',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 48,
                            height: 28,
                            child: Switch(
                              value: pushNotificationsEnabled,
                              onChanged: (bool value) => setState(() => pushNotificationsEnabled = value),
                              activeThumbColor: const Color(0xFFFFFFFF),
                              activeTrackColor: const Color(0xFF000000),
                              inactiveThumbColor: const Color(0xFFFFFFFF),
                              inactiveTrackColor: const Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(width: 19),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(width: double.infinity, height: 1, color: const Color(0xFFFFFFFF)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF000000),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: SvgPicture.asset('assets/svg/sms.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'SMS Alerts',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 48,
                            height: 28,
                            child: Switch(
                              value: smsAlertsEnabled,
                              onChanged: (bool value) => setState(() => smsAlertsEnabled = value),
                              activeThumbColor: const Color(0xFFFFFFFF),
                              activeTrackColor: const Color(0xFF000000),
                              inactiveThumbColor: const Color(0xFFFFFFFF),
                              inactiveTrackColor: const Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(width: 19),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(width: double.infinity, height: 1, color: const Color(0xFFFFFFFF)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF000000),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: SvgPicture.asset('assets/svg/mail.svg', width: 16, height: 16, colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Email Newsletter',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 48,
                            height: 28,
                            child: Switch(
                              value: emailNewsletterEnabled,
                              onChanged: (bool value) => setState(() => emailNewsletterEnabled = value),
                              activeThumbColor: const Color(0xFFFFFFFF),
                              activeTrackColor: const Color(0xFF000000),
                              inactiveThumbColor: const Color(0xFFFFFFFF),
                              inactiveTrackColor: const Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(width: 19),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 58,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F4F6),
                      foregroundColor: Theme.of(context).colorScheme.error,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFFF3F4F6), width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.error, height: 1),
                    ),
                    child: const Text('Delete Account'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
