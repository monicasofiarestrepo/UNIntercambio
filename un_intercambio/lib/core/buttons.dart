import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final EdgeInsets? padding;
  final Color? hoverColor;
  final double? radius;
  final double? minWidth;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final bool rounded;

  const PrimaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding,
    this.hoverColor,
    this.radius,
    this.minWidth,
    this.color,
    this.borderColor,
    this.textColor,
    this.rounded = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      hoverColor: hoverColor ?? SystemColors.primaryBlue.withValues(alpha: 0.8),
      disabledColor: SystemColors.neutralDark,
      elevation: 1,
      minWidth: minWidth ?? double.infinity,
      color: color ?? SystemColors.primaryBlue,
      textColor: textColor ?? SystemColors.neutralBackground,
      disabledTextColor: SystemColors.neutralBackground,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? (rounded ? 32 : 8)), 
        side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
