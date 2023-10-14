import 'package:bitsgap/presentation/theme/bitsgap_color_theme.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final bitsgapColorTheme = BitsgapColorTheme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: bitsgapColorTheme.foreground.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(
          color: bitsgapColorTheme.background,
        ),
      ),
    );
  }
}
