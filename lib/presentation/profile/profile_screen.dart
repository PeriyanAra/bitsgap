import 'package:auto_route/auto_route.dart';
import 'package:bitsgap/app/app_theme_mode/app_theme_mode.dart';
import 'package:bitsgap/common/widgets/buttons/custom_rounded_button.dart';
import 'package:bitsgap/common/widgets/custom_loader.dart';
import 'package:bitsgap/presentation.dart';
import 'package:bitsgap/presentation/theme/extensions/bitsgap_button_theme.dart';
import 'package:bitsgap/presentation/theme/extensions/profile_screen_theme.dart';
import 'package:bitsgap/presentation/theme/images.dart';
import 'package:bitsgap/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final AuthMobx _authMobx;
  late final ReactionDisposer _disposer;

  @override
  void initState() {
    _authMobx = Provider.of(context, listen: false);

    _disposer = reaction(
      (_) => _authMobx.hasError,
      (hasError) {
        if (hasError) {
          context.showErrorSnackBar(_authMobx.errorMessage);
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _disposer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileScreenTheme = ProfileScreenTheme.of(context);
    final bitsgapButtonTheme = BitsgapButtonTheme.of(context);

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: profileScreenTheme.profileAvatarSize,
                  height: profileScreenTheme.profileAvatarSize,
                  decoration: profileScreenTheme.profileAvatarDecoration,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Images.userAvatar,
                  ),
                ),
                SizedBox(
                  height: profileScreenTheme.profileAvatarSpacing,
                ),
                Padding(
                  padding: profileScreenTheme.userInfoCardPadding,
                  child: Observer(
                    builder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username: ${_authMobx.userViewModel.usename}',
                          style: profileScreenTheme.textStyle,
                        ),
                        SizedBox(
                          height: profileScreenTheme.textVerticalSpacing,
                        ),
                        Text(
                          'Email: ${_authMobx.userViewModel.email}',
                          style: profileScreenTheme.textStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: profileScreenTheme.textVerticalSpacing,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'App theme is: ${_getThemeName()}',
                      style: profileScreenTheme.textStyle,
                    ),
                    SizedBox(
                      width: profileScreenTheme.themeSwitchHorizontalSpacing,
                    ),
                    Switch.adaptive(
                      value: context.watch<AppThemeMode>().themeMode == ThemeMode.light,
                      onChanged: _onThemeChange,
                    ),
                  ],
                ),
                SizedBox(
                  width: profileScreenTheme.themeSwitchHorizontalSpacing,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: CustomRoundedButton(
                    onPressed: () {
                      Provider.of<AuthMobx>(context, listen: false).logout();
                    },
                    text: 'Log Out',
                    textStyle: bitsgapButtonTheme.textStyleChange(context),
                  ),
                ),
              ],
            ),
            Observer(
              builder: (context) {
                if (_authMobx.hasError) {
                  context.showErrorSnackBar(_authMobx.errorMessage);
                }

                return _authMobx.isLoggingOut ? const CustomLoader() : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onThemeChange(bool isLightTheme) {
    if (isLightTheme) {
      context.read<AppThemeMode>().updateThemeMode(ThemeMode.light);
    } else {
      context.read<AppThemeMode>().updateThemeMode(ThemeMode.dark);
    }
  }

  String _getThemeName() {
    if (context.watch<AppThemeMode>().themeMode == ThemeMode.light) {
      return 'Light';
    } else {
      return 'Dark';
    }
  }
}
