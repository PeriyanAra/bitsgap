import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:flutter/material.dart';


const _rotationAnimationStartValue = 10.3;

class BackgroundRectangle extends StatefulWidget {
  const BackgroundRectangle({Key? key}) : super(key: key);

  @override
  State<BackgroundRectangle> createState() => _BackgroundRectangleState();
}

class _BackgroundRectangleState extends State<BackgroundRectangle>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final authScreenTheme = AuthScreenTheme.of(context);

    return Transform.rotate(
        angle: _rotationAnimationStartValue,
        child: DecoratedBox(
          decoration: authScreenTheme.rectangleDecoration,
        ),
    );
  }
}
