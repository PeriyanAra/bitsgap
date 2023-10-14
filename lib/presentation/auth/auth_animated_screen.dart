import 'package:auto_route/auto_route.dart';
import 'package:bitsgap/common/widgets/buttons/text_button.dart';
import 'package:bitsgap/presentation.dart';
import 'package:bitsgap/presentation/auth/widgets/app_logo.dart';
import 'package:bitsgap/presentation/auth/widgets/auth_buttons_section.dart';
import 'package:bitsgap/presentation/auth/widgets/background_animated_rectangle.dart';
import 'package:bitsgap/presentation/auth/widgets/login_fields.dart';
import 'package:bitsgap/presentation/auth/widgets/sign_in_fields.dart';
import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _screenSizeFactor2_5 = 2.5;
const _screenSizeFactor = 0.1;
const _screenSizeFactor0_4 = 0.4;
const _screenSizeFactor2 = 2.0;

@RoutePage()
class AuthAnimatedScreen extends StatefulWidget {
  const AuthAnimatedScreen({super.key});

  @override
  State<AuthAnimatedScreen> createState() => _AuthAnimatedScreenState();
}

class _AuthAnimatedScreenState extends State<AuthAnimatedScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  String _email = '';
  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _pageController.addListener(() {
      _email = '';
      _username = '';
      _password = '';
    });
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final authAnimatedScreenTheme = AuthScreenTheme.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: screenSize.height * _screenSizeFactor0_4,
            left: -screenSize.width * _screenSizeFactor0_4,
            width: screenSize.width * _screenSizeFactor2,
            height: screenSize.height,
            child: const BackgroundAnimatedRectangle(),
          ),
          Positioned(
            top: screenSize.height * _screenSizeFactor,
            left: screenSize.width * _screenSizeFactor,
            child: const AppLogo(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenSize.height / _screenSizeFactor2_5,
                width: screenSize.width,
                child: PageView(
                  controller: _pageController,
                  children: [
                    LoginFields(
                      onChange: (
                        String username,
                        String password,
                      ) {
                        _username = username;
                        _password = password;
                      },
                    ),
                    SignInFields(
                      onChange: (
                        String email,
                        String username,
                        String password,
                      ) {
                        _username = username;
                        _password = password;
                        _email = email;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: authAnimatedScreenTheme.buttonsSpacing,
              ),
              AuthButtonsSection(
                onLogin: _onLogin,
                onSignUp: _onSignUp,
                pageController: _pageController,
              ),
              SizedBox(
                height: authAnimatedScreenTheme.buttonsSpacing,
              ),
              CustomTextButton(
                onTap: () {},
                text: 'Forgot password?',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onLogin() {
    Provider.of<AuthMobx>(context).login(
      username: _username,
      password: _password,
    );
  }

  void _onSignUp() {
    Provider.of<AuthMobx>(context).register(
      email: _email,
      username: _username,
      password: _password,
    );
  }
}
