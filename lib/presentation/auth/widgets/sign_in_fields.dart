import 'package:bitsgap/common/widgets/custom_text_field.dart';
import 'package:bitsgap/presentation.dart';
import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SignInFields extends StatefulWidget {
  const SignInFields({
    required this.onChange,
    super.key,
  });

  final void Function(
    String email,
    String username,
    String password,
  ) onChange;

  @override
  State<SignInFields> createState() => _SignInFieldsState();
}

class _SignInFieldsState extends State<SignInFields> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final AuthMobx _authMobx;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _authMobx = Provider.of(
      context,
      listen: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authScreenTheme = AuthScreenTheme.of(context);

    return Observer(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: authScreenTheme.textFiledPadding,
            child: CustomTextField(
              textEditingController: _emailController,
              hintText: 'Email',
              hasError: _authMobx.emailIsInvalid,
              onChanged: (_) => widget.onChange(
                _emailController.text,
                _usernameController.text,
                _passwordController.text,
              ),
            ),
          ),
          SizedBox(
            height: authScreenTheme.textFiledVerticalSpacing,
          ),
          Padding(
            padding: authScreenTheme.textFiledPadding,
            child: CustomTextField(
              textEditingController: _usernameController,
              hintText: 'Username',
              hasError: _authMobx.usernameIsInvalid,
              onChanged: (_) => widget.onChange(
                _emailController.text,
                _usernameController.text,
                _passwordController.text,
              ),
            ),
          ),
          SizedBox(
            height: authScreenTheme.textFiledVerticalSpacing,
          ),
          Padding(
            padding: authScreenTheme.textFiledPadding,
            child: CustomTextField(
              textEditingController: _passwordController,
              hintText: 'Password',
              hasError: _authMobx.passwordIsInvalid,
              obscureText: true,
              onChanged: (_) => widget.onChange(
                _emailController.text,
                _usernameController.text,
                _passwordController.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
