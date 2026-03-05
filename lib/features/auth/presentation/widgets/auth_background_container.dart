import 'package:flutter/material.dart';

class AuthBackgroundContainer extends StatelessWidget {
  final Widget body;

  const AuthBackgroundContainer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: body,
        ),
      ),
    );
  }
}
