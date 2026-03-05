import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/widgets/app_logo.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/core/extensions/context_extensions.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_background_container.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;
  bool _hasAttemptedSubmit = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundContainer(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 177,
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
                        context.go(AppRouter.signIn);
                      },
                      backgroundColor: const Color(0xFFFFFFFF),
                      iconWidget: SvgPicture.asset('assets/svg/close.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surface, BlendMode.srcIn)),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: AppLogo(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(horizontal: 21.5, vertical: 11),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 69),
                      Text('Reset Your Password!', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      Text(
                        "Let's create a new password for your account",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      AuthTextField(
                        label: 'New Password',
                        hint: 'Enter your new password',
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        isEnabled: true,
                        isObscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.newPassword],
                        textInputAction: TextInputAction.next,
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
                        validator: _validatePassword,
                        shouldShowError: _hasAttemptedSubmit,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        label: 'Confirm New Password',
                        hint: 'Re-enter your new password',
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        isEnabled: true,
                        isObscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.newPassword],
                        textInputAction: TextInputAction.done,
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        onFieldSubmitted: (_) => _submit(),
                        validator: _validateConfirmPassword,
                        shouldShowError: _hasAttemptedSubmit,
                      ),
                      const SizedBox(height: 25),
                      AuthButton(onPressed:  _submit, isLoading: false, text: 'Reset Password'),
                      const SizedBox(height: 69),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    setState(() => _hasAttemptedSubmit = true);

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.showSuccessSnackBar('Your password has been reset successfully!');

    context.go(AppRouter.signIn);
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final confirmPassword = value ?? '';
    if (confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (confirmPassword != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }
}
