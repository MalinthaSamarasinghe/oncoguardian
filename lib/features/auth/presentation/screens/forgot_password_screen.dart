import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/widgets/app_logo.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_background_container.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final FocusNode _emailFocusNode;
  bool _hasAttemptedSubmit = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
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
                        GoRouter.of(context).pop();
                      },
                      backgroundColor: const Color(0xFFFFFFFF),
                      iconWidget: SvgPicture.asset('assets/svg/back.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surface, BlendMode.srcIn)),
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
                      Text(
                        'Forgotten Password',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your email address and we’ll send a 6-digit code to your email.',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      AuthTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        isEnabled: true,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.done,
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        onFieldSubmitted: (_) => _submit(),
                        validator: _validateEmail,
                        shouldShowError: _hasAttemptedSubmit,
                      ),
                      const SizedBox(height: 24),
                      AuthButton(onPressed: _submit, isLoading: false, text: 'Send Code'),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Flexible(
                            child: Text(
                              'I remember my password.',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          Flexible(
                            flex: 0,
                            child: GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                GoRouter.of(context).pop();
                              },
                              child: Text(
                                'Sign In',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
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

    context.push(AppRouter.emailVerification);
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!email.contains('@') || !email.contains('.')) {
      return 'Enter a valid email address';
    }

    return null;
  }
}
