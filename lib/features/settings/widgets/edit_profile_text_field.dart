import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String prefixIconAssetPath;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatter;
  final TextCapitalization textCapitalization;
  final bool isEnabled;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;

  const EditProfileTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIconAssetPath,
    this.focusNode,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
    this.inputFormatter,
    this.textCapitalization = TextCapitalization.none,
    this.isEnabled = true,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  State<EditProfileTextField> createState() => _EditProfileTextFieldState();
}

class _EditProfileTextFieldState extends State<EditProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 9),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: const Color(0xFF242424),
                selectionColor: const Color(0xFF242424).withValues(alpha: 0.3),
                selectionHandleColor: const Color(0xFF242424),
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              enabled: widget.isEnabled,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
              keyboardType: widget.keyboardType,
              autofillHints: widget.autofillHints?.toList(),
              textInputAction: widget.textInputAction,
              inputFormatters: widget.inputFormatter,
              textCapitalization: widget.textCapitalization,
              onTap: widget.onTap,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.disabled,
              errorBuilder: (context, error) => const SizedBox.shrink(),
              decoration: InputDecoration(
                constraints: const BoxConstraints(minHeight: 40),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15.2),
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                hintText: widget.hint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: SvgPicture.asset(
                    widget.prefixIconAssetPath,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(Color(0xFF858585), BlendMode.srcIn),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, color: const Color(0xFF858585), height: 1.5),
                labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
