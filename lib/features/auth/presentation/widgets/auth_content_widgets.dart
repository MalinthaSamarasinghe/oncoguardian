import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class AuthTextHeadLine extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const AuthTextHeadLine({super.key, required this.text, this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineSmall, textAlign: textAlign);
  }
}

class AuthTextSubHeadLine extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const AuthTextSubHeadLine({super.key, required this.text, this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.labelMedium, textAlign: textAlign);
  }
}

class AuthTextUnderLine extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const AuthTextUnderLine({super.key, this.onPressed, required this.text, this.textAlign = TextAlign.start, this.overflow, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline),
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
  }
}

class AuthSignInDividerSection extends StatelessWidget {
  const AuthSignInDividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        const SizedBox(width: 61, child: Divider()),
        Flexible(child: Text('Or Sign In With', style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center)),
        const SizedBox(width: 61, child: Divider()),
      ],
    );
  }
}

class AuthSocialButtons extends StatelessWidget {
  final VoidCallback? onPressedApple;
  final VoidCallback? onPressedGoogle;

  const AuthSocialButtons({super.key, this.onPressedApple, this.onPressedGoogle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 11,
      children: [
        IconButton(onPressed: onPressedApple, icon: SvgPicture.asset('assets/svg/apple_icon.svg')),
        IconButton(onPressed: onPressedGoogle, icon: SvgPicture.asset('assets/svg/google_icon.svg')),
      ],
    );
  }
}

class AuthBottomSection extends StatelessWidget {
  final VoidCallback? onPressed;
  final String startText;
  final String lastText;

  const AuthBottomSection({super.key, this.onPressed, required this.startText, required this.lastText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 5,
      children: [
        Flexible(child: Text(startText, style: Theme.of(context).textTheme.labelMedium)),
        Flexible(
          flex: 0,
          child: GestureDetector(
            onTap: onPressed,
            child: Text(lastText, style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline)),
          ),
        ),
      ],
    );
  }
}
