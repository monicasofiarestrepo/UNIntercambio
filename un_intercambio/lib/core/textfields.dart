import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';

class IconTextField extends StatelessWidget {
  const IconTextField(
      {super.key, required this.controller, required this.label, this.prefixIcon, this.suffixIcon, this.obscureText = false, this.textInputType, this.validator, this.onFieldSubmitted, this.textInputAction, this.outlineColor, this.autofillHints});

  final TextEditingController controller;
  final TextInputType? textInputType;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Color? outlineColor;
  final List<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      validator: validator,
      autofillHints: autofillHints,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: outlineColor ?? SystemColors.primaryBlue,
            ),
          ),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: SystemColors.jetBlack,
                fontSize: 16,
              ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          suffixIcon: suffixIcon, 
          prefixIcon: prefixIcon),
    );
  }
}
