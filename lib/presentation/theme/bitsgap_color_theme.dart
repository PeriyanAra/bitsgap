import 'package:bitsgap/presentation/theme/bitsgap_color.dart';
import 'package:flutter/material.dart';

const _halfT = 0.5;

@immutable
class BitsgapColorTheme extends ThemeExtension<BitsgapColorTheme> {
  const BitsgapColorTheme({
    required this.brightness,
    required this.background,
    required this.foreground,
    required this.primary,
    required this.secondary,
    required this.error,
    required this.success,
  });

  final Brightness brightness;

  final BitsgapColor background;
  final BitsgapColor foreground;
  final BitsgapColor primary;
  final BitsgapColor secondary;
  final BitsgapColor error;
  final BitsgapColor success;

  @override
  int get hashCode => Object.hash(
        background,
        foreground,
        primary,
        secondary,
        error,
        success,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BitsgapColorTheme &&
          runtimeType == other.runtimeType &&
          background == other.background &&
          foreground == other.foreground &&
          primary == other.primary &&
          secondary == other.secondary &&
          error == other.error;

  @override
  BitsgapColorTheme copyWith({
    BitsgapColor? primary,
    BitsgapColor? secondary,
  }) {
    return BitsgapColorTheme(
      brightness: brightness,
      background: background,
      foreground: foreground,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      error: error,
      success: success,
    );
  }

  @override
  ThemeExtension<BitsgapColorTheme> lerp(
    covariant ThemeExtension<BitsgapColorTheme>? other,
    double t,
  ) {
    if (other is! BitsgapColorTheme) {
      return this;
    }

    return BitsgapColorTheme(
      brightness: t < _halfT ? brightness : other.brightness,
      background: background.lerp(other.background, t),
      foreground: foreground.lerp(other.foreground, t),
      primary: primary.lerp(other.primary, t),
      secondary: secondary.lerp(other.secondary, t),
      error: error.lerp(other.error, t),
      success: success.lerp(other.success, t),
    );
  }

  static BitsgapColorTheme of(BuildContext context) {
    return Theme.of(context).extension<BitsgapColorTheme>()!;
  }
}
