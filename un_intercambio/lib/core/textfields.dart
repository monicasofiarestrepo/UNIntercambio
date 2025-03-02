import 'package:flutter/material.dart';

class IconTextField extends StatefulWidget {
  const IconTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.obscureText = false,
    this.textInputType,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.outlineColor,
    this.autofillHints,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final TextInputType? textInputType;
  final String label;
  final Widget? prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Color? outlineColor;
  final List<String>? autofillHints;
  final bool readOnly;

  @override
  State<IconTextField> createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {}); // Actualiza para mostrar o no el ícono de limpiar
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.obscureText,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      autofillHints: widget.autofillHints,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: widget.outlineColor ?? Colors.blue,
          ),
        ),
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  widget.controller.clear();
                },
              )
            : null,
      ),
    );
  }
}
