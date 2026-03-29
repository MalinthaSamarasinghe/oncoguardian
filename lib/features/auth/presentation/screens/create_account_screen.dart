import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/enums/authentication_status.dart';
import 'package:oncoguardian/core/extensions/context_extensions.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_content_widgets.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_inner_background_container.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;
  bool _agreedToTerms = false;
  bool _hasAttemptedSubmit = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final isLoading = state.authenticationStatus == AuthenticationStatus.loading;
                    return Column(
                      children: [
                        const SizedBox(height: 33),
                        const AuthTextHeadLine(text: 'Create Account'),
                        const SizedBox(height: 8),
                        const AuthTextSubHeadLine(text: 'Fill Your information or register with social account'),
                        const SizedBox(height: 22),
                        AuthTextField(
                          label: 'Name',
                          hint: 'Enter your name',
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          isEnabled: !isLoading,
                          keyboardType: TextInputType.name,
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
                          validator: _validateName,
                          shouldShowError: _hasAttemptedSubmit,
                          isRequiredField: true,
                        ),
                        const SizedBox(height: 16),
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
                          isRequiredField: true,
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
                          textInputAction: TextInputAction.next,
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
                          validator: _validatePassword,
                          shouldShowError: _hasAttemptedSubmit,
                          isRequiredField: true,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: 'Confirm Password',
                          hint: 'Confirm your password',
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          isEnabled: !isLoading,
                          isObscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          onFieldSubmitted: (_) => _submit(),
                          validator: _validateConfirmPassword,
                          shouldShowError: _hasAttemptedSubmit,
                          isRequiredField: true,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: isLoading
                                  ? null
                                  : (bool? value) {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      setState(() => _agreedToTerms = value ?? false);
                                    },
                              fillColor: WidgetStateProperty.all(_agreedToTerms ? null : Colors.transparent),
                            ),
                            const Flexible(flex: 0, child: AuthTextSubHeadLine(text: 'Agree with')),
                            const SizedBox(width: 6),
                            Flexible(
                              child: AuthTextUnderLine(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        setState(() => _agreedToTerms = true);
                                        context.push(AppRouter.termConditions);
                                      },
                                text: 'Terms & Conditions',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        AuthButton(onPressed: isLoading ? null : _submit, isLoading: isLoading, text: 'Sign Up'),
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
                                  context.go(AppRouter.signIn);
                                },
                          startText: 'Already have an account?',
                          lastText: 'Sign In',
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

    if (!_agreedToTerms) {
      context.showErrorSnackBar('Please agree to the Terms & Conditions');
      return;
    }

    context.read<AuthenticationBloc>().add(
      CreateAccountEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _nameController.text.trim(),
      ),
    );
  }

  String? _validateName(String? value) {
    final parts = (value ?? '').trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();

    if (parts.isEmpty) {
      return 'Name is required';
    }

    if (parts.length < 2) {
      return 'Enter first and last name';
    }

    return null;
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

  String? _validateConfirmPassword(String? value) {
    final confirmation = value ?? '';
    if (confirmation.isEmpty) {
      return 'Confirm password is required';
    }

    if (confirmation != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }
}
