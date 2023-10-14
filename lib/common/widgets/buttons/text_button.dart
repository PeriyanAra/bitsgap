import 'package:bitsgap/presentation/theme/extensions/bitsgap_button_theme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.onTap,
    required this.text,
    this.textStyle,
    super.key,
  });

  final VoidCallback onTap;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final bitsgapButtonTheme = BitsgapButtonTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: textStyle ?? bitsgapButtonTheme.textStyle1,
      ),
    );
  }
}
