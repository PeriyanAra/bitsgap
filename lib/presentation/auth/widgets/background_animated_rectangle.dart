import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:flutter/material.dart';

const _rotationAnimationStartValue = 10.3;
const _rotationAnimationEndValue = 360.0;
const _rotationAnimationDuration = Duration(minutes: 120);

class BackgroundAnimatedRectangle extends StatefulWidget {
  const BackgroundAnimatedRectangle({Key? key}) : super(key: key);

  @override
  State<BackgroundAnimatedRectangle> createState() => _BackgroundAnimatedRectangleState();
}

class _BackgroundAnimatedRectangleState extends State<BackgroundAnimatedRectangle>
    with SingleTickerProviderStateMixin {
  late Animation<double> _rotationAnimation;

  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: _rotationAnimationDuration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: _rotationAnimationStartValue,
      end: _rotationAnimationEndValue,
    ).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.linear,
      ),
    );

    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authScreenTheme = AuthScreenTheme.of(context);

    return AnimatedBuilder(
      animation: _rotationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: DecoratedBox(
            decoration: authScreenTheme.rectangleDecoration,
          ),
        );
      },
    );
  }
}
