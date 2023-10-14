import 'package:auto_route/auto_route.dart';
import 'package:bitsgap/common/widgets/buttons/text_button.dart';
import 'package:bitsgap/common/widgets/custom_loader.dart';
import 'package:bitsgap/presentation.dart';
import 'package:bitsgap/presentation/auth/widgets/app_logo.dart';
import 'package:bitsgap/presentation/auth/widgets/auth_buttons_section.dart';
import 'package:bitsgap/presentation/auth/widgets/background_rectangle.dart';
import 'package:bitsgap/presentation/auth/widgets/login_fields.dart';
import 'package:bitsgap/presentation/auth/widgets/sign_in_fields.dart';
import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:bitsgap/presentation/ui_kit/snack_bar/bitsgap_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

const _screenSizeFactor = 0.1;
const _screenSizeFactor0_4 = 0.4;
const _screenSizeFactor0_3 = 0.3;
const _screenSizeFactor2 = 2.0;
const _screenSizeFactor2_4 = 2.4;

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AuthMobx _authMobx;
  late final ReactionDisposer _errorDisposer;
  late final ReactionDisposer _successDisposer;
  String _email = '';
  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _authMobx = Provider.of<AuthMobx>(context, listen: false);
    _pageController = PageController();

    _errorDisposer = reaction(
      (_) => _authMobx.hasError,
      (hasError) {
        if (hasError) {
          context.showErrorSnackBar(_authMobx.errorMessage);
        }
      },
    );

    _successDisposer = reaction(
      (_) => _authMobx.isAuthenticated,
      (hasError) {
        if (hasError) {
          context.showSuccessSnackBar('You are successfully authenticated');
        }
      },
    );

    _pageController.addListener(() {
      _email = '';
      _username = '';
      _password = '';
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _errorDisposer();
    _successDisposer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final authScreenTheme = AuthScreenTheme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: screenSize.height * _screenSizeFactor0_3,
            left: -screenSize.width * _screenSizeFactor0_4,
            width: screenSize.width * _screenSizeFactor2,
            height: screenSize.height,
            child: const BackgroundRectangle(),
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
                height: screenSize.height / _screenSizeFactor2_4,
                width: screenSize.width,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
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
                height: authScreenTheme.buttonsSpacing,
              ),
              AuthButtonsSection(
                onLogin: _onLogin,
                onSignUp: _onSignUp,
                pageController: _pageController,
              ),
              SizedBox(
                height: authScreenTheme.buttonsSpacing,
              ),
              CustomTextButton(
                onTap: () {},
                text: 'Forgot password?',
              ),
            ],
          ),
          Observer(
            builder: (context) {
              return _authMobx.isAuthenticating ? const CustomLoader() : const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  void _onLogin() {
    FocusScope.of(context).unfocus();

    _authMobx.login(
      username: _username,
      password: _password,
    );
  }

  void _onSignUp() {
    FocusScope.of(context).unfocus();

    _authMobx.register(
      email: _email,
      username: _username,
      password: _password,
    );
  }
}
