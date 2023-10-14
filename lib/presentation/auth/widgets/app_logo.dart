import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:bitsgap/presentation/theme/images.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppLogo extends StatefulWidget {
  const AppLogo({super.key});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final authScreenTheme = AuthScreenTheme.of(context);

    return SvgPicture.asset(
      Images.batsLogo,
      width: authScreenTheme.logoSize,
      height: authScreenTheme.logoSize,
    );
  }
}
