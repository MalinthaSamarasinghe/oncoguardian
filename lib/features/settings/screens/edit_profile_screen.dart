import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/features/settings/widgets/edit_profile_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
            title: const Text('Edit Profile'),
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
                const SizedBox(height: 25),
                EditProfileTextField(
                  label: 'Full Name',
                  hint: 'Full Name',
                  controller: TextEditingController(text: 'Anushka Gamage'),
                  prefixIconAssetPath: 'assets/svg/person.svg',
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.name],
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  onFieldSubmitted: (String text) {},
                  onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
                const SizedBox(height: 23),
                EditProfileTextField(
                  label: 'Email Address',
                  hint: 'Email Address',
                  controller: TextEditingController(text: 'anushka.gamage@gmail.com'),
                  prefixIconAssetPath: 'assets/svg/mail.svg',
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String text) {},
                  onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
                const SizedBox(height: 23),
                EditProfileTextField(
                  label: 'Phone Number',
                  hint: 'Phone Number',
                  controller: TextEditingController(text: '+94 77 123 4567'),
                  prefixIconAssetPath: 'assets/svg/phone.svg',
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (String text) {},
                  onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
                const SizedBox(height: 33),
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF242424),
                      foregroundColor: const Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, height: 1),
                    ),
                    child: const Text('Save Changes'),
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
