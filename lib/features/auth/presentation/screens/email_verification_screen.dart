import 'package:pinput/pinput.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/widgets/app_logo.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_background_container.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  static const int _codeLength = 6;
  late final TextEditingController _pinController;
  late final FocusNode _focusNode;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    _formKey = GlobalKey<FormState>();
    _pinController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 50,
      textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16, color: const Color(0xFF525252), height: 1.38),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xFFFFFFFF)),
    );

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
                child: Column(
                  children: [
                    const SizedBox(height: 69),
                    Text('Verify Code', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                    const SizedBox(height: 7),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Please enter the code we just sent to your email\n',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          TextSpan(
                            text: 'johndoe@gmail.com',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Pinput(
                              controller: _pinController,
                              focusNode: _focusNode,
                              length: _codeLength,
                              enabled: true,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              autofillHints: const [AutofillHints.oneTimeCode],
                              hapticFeedbackType: HapticFeedbackType.lightImpact,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                              pinAnimationType: PinAnimationType.scale,
                              separatorBuilder: (index) => const SizedBox(width: 8),
                              defaultPinTheme: defaultPinTheme,
                              submittedPinTheme: defaultPinTheme,
                              errorPinTheme: defaultPinTheme,
                              validator: _validateCode,
                              errorTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error, height: 1.2),
                              onCompleted: (pin) => debugPrint('onCompleted: $pin'),
                              onChanged: (value) => debugPrint('onChanged: $value'),
                              showCursor: true,
                              isCursorAnimationEnabled: true,
                              preFilledWidget: _buildPinPlaceholder(context),
                              cursor: _buildPinPlaceholder(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        Text(
                          "Didn't receive an email?",
                          style: Theme.of(context).textTheme.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: Text(
                            'Resend Code',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    AuthButton(onPressed: _submit, isLoading: false, text: 'Verify'),
                    const SizedBox(height: 68),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinPlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            '_',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16, color: const Color(0xFF9E9C9D), height: 1.38),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    _focusNode.unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.push(AppRouter.createNewPassword);
  }

  String? _validateCode(String? value) {
    final code = value?.trim() ?? '';
    if (code.length != _codeLength) {
      return 'Enter the $_codeLength-digit code';
    }
    return null;
  }
}
