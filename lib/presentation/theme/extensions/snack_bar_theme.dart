import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class SnackBarTheme extends ThemeExtension<SnackBarTheme> {
  SnackBarTheme({
    required BitsgapColorTheme colorTheme,
  }) : _colorTheme = colorTheme;

  final BitsgapColorTheme _colorTheme;

  TextStyle get titleTextStyle => const TextStyle(
        color: BitsgapColorsPalette.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );

  TextStyle get messageTextStyle => const TextStyle(
        color: BitsgapColorsPalette.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      );

  BorderRadius get snackBarRadius => const BorderRadius.all(
        Radius.circular(
          12.0,
        ),
      );

  EdgeInsets get snackBarPadding => const EdgeInsets.all(12.0);

  EdgeInsets get snackBarMargin => const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0);

  double get snackBarPrefixIconHorizontalSpacing => 12.0;

  EdgeInsets get snackBarSuffixIconPadding =>
      const EdgeInsets.only(left: 12.0, bottom: 12.0, top: 12.0);

  @override
  ThemeExtension<SnackBarTheme> copyWith({
    BorderRadius? borderRadius,
    BitsgapColorTheme? colorTheme,
  }) {
    return SnackBarTheme(
      colorTheme: colorTheme ?? _colorTheme,
    );
  }

  @override
  ThemeExtension<SnackBarTheme> lerp(
    covariant ThemeExtension<SnackBarTheme>? other,
    double t,
  ) {
    if (other is! SnackBarTheme) {
      return this;
    }

    return SnackBarTheme(
      colorTheme: _colorTheme,
    );
  }

  static SnackBarTheme of(BuildContext context) {
    return Theme.of(context).extension<SnackBarTheme>()!;
  }
}
