import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class AuthScreenTheme extends ThemeExtension<AuthScreenTheme> {
  AuthScreenTheme({
    required BitsgapColorTheme colorTheme,
  }) : _colorTheme = colorTheme;

  final BitsgapColorTheme _colorTheme;

  BoxDecoration get rectangleDecoration => BoxDecoration(
        color: _colorTheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(120.0),
        ),
      );

  double get logoSize => 50.0;

  double get buttonsSpacing => 32.0;

  double get textFiledVerticalSpacing => 12.0;

  EdgeInsets get textFiledPadding => const EdgeInsets.symmetric(horizontal: 24.0);

  @override
  ThemeExtension<AuthScreenTheme> copyWith({
    BorderRadius? borderRadius,
    BitsgapColorTheme? colorTheme,
  }) {
    return AuthScreenTheme(
      colorTheme: colorTheme ?? _colorTheme,
    );
  }

  @override
  ThemeExtension<AuthScreenTheme> lerp(
    covariant ThemeExtension<AuthScreenTheme>? other,
    double t,
  ) {
    if (other is! AuthScreenTheme) {
      return this;
    }

    return AuthScreenTheme(
      colorTheme: _colorTheme,
    );
  }

  static AuthScreenTheme of(BuildContext context) {
    return Theme.of(context).extension<AuthScreenTheme>()!;
  }
}
