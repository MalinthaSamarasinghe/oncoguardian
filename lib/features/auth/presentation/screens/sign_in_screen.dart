import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/enums/authentication_status.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_content_widgets.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_inner_background_container.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  bool _hasAttemptedSubmit = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!, style: const TextStyle(color: Color(0xFFFFFFFF))),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: AuthInnerBackgroundContainer(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 31),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final isLoading = state.authenticationStatus == AuthenticationStatus.loading;
                    return Column(
                      children: [
                        const SizedBox(height: 45),
                        const AuthTextHeadLine(text: 'Sign In'),
                        const SizedBox(height: 8),
                        const AuthTextSubHeadLine(text: 'Hello, Welcome to the Oncoguardian!'),
                        const SizedBox(height: 34),
                        AuthTextField(
                          label: 'Email',
                          hint: 'Enter your email',
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          isEnabled: !isLoading,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                          validator: _validateEmail,
                          shouldShowError: _hasAttemptedSubmit,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          isEnabled: !isLoading,
                          isObscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          onFieldSubmitted: (_) => _submit(),
                          validator: _validatePassword,
                          shouldShowError: _hasAttemptedSubmit,
                        ),
                        const SizedBox(height: 17),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AuthTextUnderLine(
                            onPressed: isLoading
                                ? null
                                : () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    context.push(AppRouter.forgotPassword);
                                  },
                            text: 'Forgot Password?',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 34),
                        AuthButton(onPressed: isLoading ? null : _submit, isLoading: isLoading, text: 'Sign In'),
                        const SizedBox(height: 23),
                        const AuthSignInDividerSection(),
                        const SizedBox(height: 25),
                        AuthSocialButtons(
                          onPressedApple: isLoading
                              ? null
                              : () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                },
                          onPressedGoogle: isLoading
                              ? null
                              : () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                },
                        ),
                        const SizedBox(height: 24),
                        AuthBottomSection(
                          onPressed: isLoading
                              ? null
                              : () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  context.go(AppRouter.createAccount);
                                },
                          startText: "Don't have an account?",
                          lastText: 'Sign Up',
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
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

    context.read<AuthenticationBloc>().add(
      SignInEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
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
}
