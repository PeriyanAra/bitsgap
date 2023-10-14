import 'dart:ui';
import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class BitsgapInputFieldTheme extends ThemeExtension<BitsgapInputFieldTheme> {
  BitsgapInputFieldTheme({
    this.borderRadius = defaultBorderRadius,
    this.borderWidth = 1.0,
    this.horizontalPadding = defaultHorizontalPadding,
    this.verticalPadding = defaultVerticalPadding,
    required this.colorTheme,
  });

  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(24.0));
  static const double defaultHorizontalPadding = 16.0;
  static const double defaultVerticalPadding = 12.0;

  final BorderRadius borderRadius;
  final BitsgapColorTheme colorTheme;

  final double horizontalPadding;
  final double verticalPadding;
  final double borderWidth;

  TextStyle get defaultTextStyle => TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: colorTheme.foreground,
      );

  @override
  ThemeExtension<BitsgapInputFieldTheme> copyWith({
    BorderRadius? borderRadius,
    double? horizontalPadding,
    double? verticalPadding,
    double? borderWidth,
    BitsgapColorTheme? colorTheme,
  }) {
    return BitsgapInputFieldTheme(
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      colorTheme: colorTheme ?? this.colorTheme,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      verticalPadding: verticalPadding ?? this.verticalPadding,
    );
  }

  @override
  ThemeExtension<BitsgapInputFieldTheme> lerp(
    covariant ThemeExtension<BitsgapInputFieldTheme>? other,
    double t,
  ) {
    if (other is! BitsgapInputFieldTheme) {
      return this;
    }

    return BitsgapInputFieldTheme(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      colorTheme: colorTheme,
      horizontalPadding: lerpDouble(horizontalPadding, other.horizontalPadding, t)!,
      verticalPadding: lerpDouble(verticalPadding, other.verticalPadding, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
    );
  }

  static BitsgapInputFieldTheme of(BuildContext context) {
    return Theme.of(context).extension<BitsgapInputFieldTheme>()!;
  }
}
