import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreenTheme extends ThemeExtension<ProfileScreenTheme> {
  ProfileScreenTheme({
    required BitsgapColorTheme colorTheme,
  }) : _colorTheme = colorTheme;

  final BitsgapColorTheme _colorTheme;

  TextStyle get textStyle => TextStyle(
        color: _colorTheme.foreground,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      );

  double get profileAvatarSize => 150.0;

  double get profileAvatarSpacing => 30.0;

  double get themeSwitchHorizontalSpacing => 10.0;

  double get textVerticalSpacing => 10.0;

  EdgeInsets get userInfoCardPadding => const EdgeInsets.symmetric(horizontal: 20);

  BitsgapColor get cardBackgroundColor => _colorTheme.background;

  BoxDecoration get profileAvatarDecoration => BoxDecoration(
        shape: BoxShape.circle,
        color: _colorTheme.foreground,
      );

  @override
  ThemeExtension<ProfileScreenTheme> copyWith({
    BorderRadius? borderRadius,
    BitsgapColorTheme? colorTheme,
  }) {
    return ProfileScreenTheme(
      colorTheme: colorTheme ?? _colorTheme,
    );
  }

  @override
  ThemeExtension<ProfileScreenTheme> lerp(
    covariant ThemeExtension<ProfileScreenTheme>? other,
    double t,
  ) {
    if (other is! ProfileScreenTheme) {
      return this;
    }

    return ProfileScreenTheme(
      colorTheme: _colorTheme,
    );
  }

  static ProfileScreenTheme of(BuildContext context) {
    return Theme.of(context).extension<ProfileScreenTheme>()!;
  }
}
