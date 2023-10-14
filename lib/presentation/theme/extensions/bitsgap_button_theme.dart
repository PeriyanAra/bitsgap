import 'dart:ui';
import 'package:bitsgap/app/app_theme_mode/app_theme_mode.dart';
import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BitsgapButtonTheme extends ThemeExtension<BitsgapButtonTheme> {
  BitsgapButtonTheme({
    this.borderRadius = defaultBorderRadius,
    this.horizontalPadding = defaultHorizontalPadding,
    this.verticalPadding = defaultVerticalPadding,
    this.primaryButtonColor = defaultPrimaryButtonColor,
    this.transparent = defaultTransparent,
    required this.colorTheme,
  });

  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(20.0));
  static const double defaultHorizontalPadding = 24.0;
  static const double defaultVerticalPadding = 10.0;
  static const Color defaultPrimaryButtonColor = BitsgapColorsPalette.royalBlue;
  static const Color defaultTransparent = Colors.transparent;

  final BorderRadius borderRadius;
  final BitsgapColorTheme colorTheme;
  final Color primaryButtonColor;
  final Color transparent;

  final double horizontalPadding;
  final double verticalPadding;

  TextStyle textStyleChange(BuildContext context) {
    final themeMode = context.watch<AppThemeMode>().themeMode;
    final bitsgapButtonTheme = BitsgapButtonTheme.of(context);

    if (themeMode == ThemeMode.dark) {
      return bitsgapButtonTheme.textStyle1;
    } else {
      return bitsgapButtonTheme.textStyle2;
    }
  }

  TextStyle get textStyle1 => TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: colorTheme.foreground,
      );

  TextStyle get textStyle2 => TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: colorTheme.background,
      );

  ButtonStyle get defaultButtonStyle {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      backgroundColor: BitsgapColorsPalette.royalBlue,
    );
  }

  @override
  ThemeExtension<BitsgapButtonTheme> copyWith({
    BorderRadius? borderRadius,
    double? horizontalPadding,
    double? verticalPadding,
    BitsgapColorTheme? colorTheme,
    BitsgapColorsPalette? colorsPalette,
  }) {
    return BitsgapButtonTheme(
      borderRadius: borderRadius ?? this.borderRadius,
      colorTheme: colorTheme ?? this.colorTheme,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      verticalPadding: verticalPadding ?? this.verticalPadding,
    );
  }

  @override
  ThemeExtension<BitsgapButtonTheme> lerp(
    covariant ThemeExtension<BitsgapButtonTheme>? other,
    double t,
  ) {
    if (other is! BitsgapButtonTheme) {
      return this;
    }

    return BitsgapButtonTheme(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      colorTheme: colorTheme,
      horizontalPadding: lerpDouble(horizontalPadding, other.horizontalPadding, t)!,
      verticalPadding: lerpDouble(verticalPadding, other.verticalPadding, t)!,
    );
  }

  static BitsgapButtonTheme of(BuildContext context) {
    return Theme.of(context).extension<BitsgapButtonTheme>()!;
  }
}
