import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/core/enums/authentication_status.dart';
import 'package:oncoguardian/features/settings/widgets/edit_profile_text_field.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _phoneFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phoneNumber ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _handleSaveChanges(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Dispatch UpdateProfileEvent to BLoC
    context.read<AuthenticationBloc>().add(
      UpdateProfileEvent(fullName: _nameController.text.trim()),
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
        if (state.authenticationStatus == AuthenticationStatus.authenticated && context.read<AuthenticationBloc>().state.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully', style: TextStyle(color: Color(0xFFFFFFFF))),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: GestureDetector(
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
                  iconWidget: SvgPicture.asset(
                    'assets/svg/back.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  final isLoading = state.authenticationStatus == AuthenticationStatus.loading;
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25),
                        EditProfileTextField(
                          label: 'Full Name',
                          hint: 'Full Name',
                          controller: _nameController,
                          prefixIconAssetPath: 'assets/svg/person.svg',
                          focusNode: _nameFocusNode,
                          keyboardType: TextInputType.name,
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          isEnabled: !isLoading,
                          validator: _validateName,
                          onFieldSubmitted: (String text) => _emailFocusNode.requestFocus(),
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        ),
                        const SizedBox(height: 23),
                        EditProfileTextField(
                          label: 'Email Address',
                          hint: 'Email Address',
                          controller: _emailController,
                          prefixIconAssetPath: 'assets/svg/mail.svg',
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          isEnabled: false,
                          validator: _validateEmail,
                          onFieldSubmitted: (String text) => _phoneFocusNode.requestFocus(),
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        ),
                        const SizedBox(height: 23),
                        EditProfileTextField(
                          label: 'Phone Number',
                          hint: 'Phone Number',
                          controller: _phoneController,
                          prefixIconAssetPath: 'assets/svg/phone.svg',
                          focusNode: _phoneFocusNode,
                          keyboardType: TextInputType.phone,
                          autofillHints: const [AutofillHints.telephoneNumber],
                          textInputAction: TextInputAction.done,
                          isEnabled: false,
                          onFieldSubmitted: (String text) {},
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        ),
                        const SizedBox(height: 33),
                        SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => _handleSaveChanges(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF242424),
                              foregroundColor: const Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, height: 1),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  )
                                : const Text('Save Changes'),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
