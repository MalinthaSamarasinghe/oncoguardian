import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountSettingsTextField extends StatefulWidget {
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

  const AccountSettingsTextField({
    super.key,
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
  });

  @override
  State<AccountSettingsTextField> createState() => _AccountSettingsTextFieldState();
}

class _AccountSettingsTextFieldState extends State<AccountSettingsTextField> {
  bool isHidden = true;

  void _toggleVisibility() => setState(() => isHidden = !isHidden);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        enabled: widget.isEnabled,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.43),
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
          constraints: const BoxConstraints(minHeight: 36, maxHeight: 36),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFF858585), height: 1.43),
          labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.43),
        ),
      ),
    );
  }
}
