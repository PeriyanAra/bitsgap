import 'package:bitsgap/common/widgets/buttons/custom_rounded_button.dart';
import 'package:bitsgap/presentation/theme/extensions/bitsgap_button_theme.dart';
import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

const _animationDuration = Duration(milliseconds: 200);

class AuthButtonsSection extends StatefulWidget {
  const AuthButtonsSection({
    required this.pageController,
    required this.onLogin,
    required this.onSignUp,
    super.key,
  });

  final PageController pageController;
  final VoidCallback onLogin;
  final VoidCallback onSignUp;

  @override
  State<AuthButtonsSection> createState() => _AuthButtonsSectionState();
}

class _AuthButtonsSectionState extends State<AuthButtonsSection> {
  bool isLoginSelected = true;
  bool isSignUpSelected = false;

  @override
  Widget build(BuildContext context) {
    final bitsgapColorTheme = BitsgapColorTheme.of(context);
    final bitsgapButtonTheme = BitsgapButtonTheme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: bitsgapButtonTheme.horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: bitsgapColorTheme.secondary.dark,
        borderRadius: bitsgapButtonTheme.borderRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomRoundedButton(
              onPressed: () {
                if (isLoginSelected) {
                  widget.onLogin();
                }
                if (widget.pageController.page == 1) {
                  setState(() {
                    isLoginSelected = true;
                    isSignUpSelected = false;
                  });
                  widget.pageController.previousPage(
                    duration: _animationDuration,
                    curve: Curves.easeInOut,
                  );
                }
              },
              text: 'Login',
              textStyle:
                  isLoginSelected ? bitsgapButtonTheme.textStyleChange(context) : bitsgapButtonTheme.textStyle1,
              backgroundColor:
                  isLoginSelected ? bitsgapButtonTheme.primaryButtonColor : bitsgapButtonTheme.transparent,
            ),
          ),
          Expanded(
            child: CustomRoundedButton(
              onPressed: () {
                if (isSignUpSelected) {
                  widget.onSignUp();
                }

                if (widget.pageController.page == 0) {
                  setState(() {
                    isSignUpSelected = true;
                    isLoginSelected = false;
                  });
                  widget.pageController.nextPage(
                    duration: _animationDuration,
                    curve: Curves.easeInOut,
                  );
                }
              },
              text: 'Sign-up',
              textStyle:
                  isSignUpSelected ? bitsgapButtonTheme.textStyleChange(context) : bitsgapButtonTheme.textStyle1,
              backgroundColor:
                  isSignUpSelected ? bitsgapButtonTheme.primaryButtonColor : bitsgapButtonTheme.transparent,
            ),
          ),
        ],
      ),
    );
  }

  
}
