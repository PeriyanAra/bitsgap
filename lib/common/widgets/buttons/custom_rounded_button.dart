import 'package:bitsgap/presentation/theme/extensions/bitsgap_button_theme.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    this.isExpanded = true,
    this.onPressed,
    this.text,
    this.textStyle,
    this.backgroundColor,
    super.key,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final bitsgapButtonTheme = BitsgapButtonTheme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: bitsgapButtonTheme.borderRadius,
          color: backgroundColor ?? bitsgapButtonTheme.primaryButtonColor,
        ),
        width: isExpanded ? double.infinity : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: bitsgapButtonTheme.horizontalPadding,
            vertical: bitsgapButtonTheme.verticalPadding,
          ),
          child: Center(
            child: Text(
              text ?? '',
              style: textStyle ?? bitsgapButtonTheme.textStyle1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
