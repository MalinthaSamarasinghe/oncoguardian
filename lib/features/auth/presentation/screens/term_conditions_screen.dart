import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_button.dart';
import 'package:oncoguardian/features/auth/presentation/widgets/auth_inner_background_container.dart';

class TermConditionsScreen extends StatefulWidget {
  const TermConditionsScreen({super.key});

  @override
  State<TermConditionsScreen> createState() => _TermConditionsScreenState();
}

class _TermConditionsScreenState extends State<TermConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthInnerBackgroundContainer(
      isTermConditionScreen: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Terms and Conditions',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 25),
              Text(
                '1. Introduction',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 15, height: 1.83),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 11),
              Text(
                'Welcome to our Terms and Conditions. Your privacy is critically important to us. It is our policy to respect your privacy '
                'regarding any information we may collect while operating our mobile application.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.76),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Text(
                '2. Information We Collect',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 15, height: 1.83),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 11),
              Text(
                'We collect information that you provide directly to us. For example, we collect information when you create an account, '
                'subscribe, participate in any interactive features of our services, fill out a form, request customer support, or '
                'otherwise communicate with us.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.76),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),
              Text(
                '• Name and contact information',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.76),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 3),
              Text(
                '• Account credentials',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.76),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 3),
              Text(
                '• Device and usage information',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.76),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Text(
                '3. How We Use Information',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 15, height: 1.83),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 11),
              Text(
                'We use the information we collect to provide, maintain, and improve our services, such as to administer your account, '
                'process transactions, and send you technical notices and support messages.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.76),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 42),
              AuthButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  GoRouter.of(context).pop();
                },
                text: 'I Accept',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
