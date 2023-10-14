import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

final whiteColor = BitsgapColor(Colors.white.value);

BitsgapColorTheme createColorTheme(BitsgapColor color) {
  return BitsgapColorTheme(
    brightness: Brightness.light,
    background: color,
    foreground: color,
    primary: color,
    secondary: color,
    error: color,
    success: color,
  );
}
