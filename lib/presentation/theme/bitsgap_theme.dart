import 'package:bitsgap/presentation/theme/bitsgap_color.dart';
import 'package:bitsgap/presentation/theme/bitsgap_color_theme.dart';
import 'package:bitsgap/presentation/theme/bitsgap_colors_palette.dart';
import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:bitsgap/presentation/theme/extensions/bitsgap_button_theme.dart';
import 'package:bitsgap/presentation/theme/extensions/extensions.dart';
import 'package:bitsgap/presentation/theme/extensions/profile_screen_theme.dart';
import 'package:bitsgap/presentation/theme/extensions/snack_bar_theme.dart';
import 'package:flutter/material.dart';

class BitsgapTheme {
  static ThemeData light() {
    final colorTheme = _lightColorTheme();
    final inputFieldTheme = BitsgapInputFieldTheme(colorTheme: colorTheme);
    final buttonTheme = BitsgapButtonTheme(
      colorTheme: colorTheme,
    );
    final authScreenTheme = AuthScreenTheme(
      colorTheme: colorTheme,
    );
    final snackBarTheme = SnackBarTheme(
      colorTheme: colorTheme,
    );

    final profileScreenTheme = ProfileScreenTheme(
      colorTheme: colorTheme,
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorTheme.primary,
      ),
      applyElevationOverlayColor: false,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: colorTheme.secondary,
      extensions: <ThemeExtension<dynamic>>[
        colorTheme,
        inputFieldTheme,
        buttonTheme,
        authScreenTheme,
        profileScreenTheme,
        snackBarTheme,
      ],
    );
  }

  static ThemeData dark() {
    final colorTheme = _darkColorTheme();

    final inputFieldTheme = BitsgapInputFieldTheme(colorTheme: colorTheme);
    final buttonTheme = BitsgapButtonTheme(
      colorTheme: colorTheme,
    );
    final authScreenTheme = AuthScreenTheme(
      colorTheme: colorTheme,
    );
    final profileScreenTheme = ProfileScreenTheme(
      colorTheme: colorTheme,
    );
    final snackBarTheme = SnackBarTheme(
      colorTheme: colorTheme,
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorTheme.primary,
      ),
      applyElevationOverlayColor: false,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: colorTheme.secondary,
      extensions: <ThemeExtension<dynamic>>[
        colorTheme,
        inputFieldTheme,
        buttonTheme,
        authScreenTheme,
        profileScreenTheme,
        snackBarTheme,
      ],
    );
  }

  static BitsgapColorTheme _lightColorTheme() {
    return _baseColorTheme(
      brightness: Brightness.light,
      background: BitsgapColor(
        BitsgapColorsPalette.floralWhite.value,
      ),
      foreground: BitsgapColor(
        BitsgapColorsPalette.midnightExpress.value,
      ),
      primary: BitsgapColor(
        BitsgapColorsPalette.catalinaBlueDark.value,
      ),
      secondary: BitsgapColor(
        BitsgapColorsPalette.catalinaBlueLight.value,
      ),
    );
  }

  static BitsgapColorTheme _darkColorTheme() {
    return _baseColorTheme(
      brightness: Brightness.dark,
      background: BitsgapColor(
        BitsgapColorsPalette.nero.value,
      ),
      foreground: BitsgapColor(
        BitsgapColorsPalette.white.value,
      ),
      primary: BitsgapColor(
        BitsgapColorsPalette.stateBlueLight.value,
      ),
      secondary: BitsgapColor(
        BitsgapColorsPalette.stateBlueDark.value,
      ),
    );
  }

  /////////////////////////////////////////////////////////////////
  /************************* BASE ********************************/
  /////////////////////////////////////////////////////////////////

  static BitsgapColorTheme _baseColorTheme({
    required Brightness brightness,
    required BitsgapColor background,
    required BitsgapColor foreground,
    required BitsgapColor primary,
    required BitsgapColor secondary,
  }) {
    return BitsgapColorTheme(
      brightness: brightness,
      background: background,
      foreground: foreground,
      primary: primary,
      secondary: secondary,
      error: BitsgapColor(
        BitsgapColorsPalette.harleyDavidsonOrange.value,
      ),
      success: BitsgapColor(
        BitsgapColorsPalette.jade.value,
      ),
    );
  }
}
