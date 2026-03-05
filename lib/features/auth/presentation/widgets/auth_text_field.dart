import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatter;
  final TextCapitalization textCapitalization;
  final bool isObscureText;
  final bool isEnabled;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool shouldShowError;
  final bool isRequiredField;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.focusNode,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
    this.inputFormatter,
    this.textCapitalization = TextCapitalization.none,
    this.isObscureText = false,
    this.isEnabled = true,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.shouldShowError = false,
    this.isRequiredField = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isHidden = true;

  void _toggleVisibility() => setState(() => isHidden = !isHidden);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (widget.isRequiredField) ...[
                TextSpan(
                  text: '*',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFEB5640), fontWeight: FontWeight.w700),
                ),
              ],
            ],
          ),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.isEnabled,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFF525252)),
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints?.toList(),
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatter,
          textCapitalization: widget.textCapitalization,
          obscureText: widget.isObscureText ? isHidden : false,
          enableSuggestions: !widget.isObscureText,
          autocorrect: !widget.isObscureText,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.disabled,
          errorBuilder: (context, error) => const SizedBox.shrink(),
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: widget.isObscureText
                ? GestureDetector(
                    onTap: _toggleVisibility,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 10),
                      child: SvgPicture.asset(
                        isHidden ? 'assets/svg/password_off.svg' : 'assets/svg/password_on.svg',
                        colorFilter: const ColorFilter.mode(Color(0xFF858585), BlendMode.srcIn),
                      ),
                    ),
                  )
                : null,
          ),
        ),
        // Custom error display only when shouldShowError is true
        if (widget.shouldShowError && widget.validator != null) ...[_buildCustomErrorDisplay(context)],
      ],
    );
  }

  Widget _buildCustomErrorDisplay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller,
        builder: (context, value, _) {
          final error = widget.validator?.call(value.text);
          if (error == null || error.isEmpty) {
            return const SizedBox.shrink();
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error, height: 1.2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }
}
