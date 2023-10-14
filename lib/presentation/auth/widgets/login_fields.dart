import 'package:bitsgap/common/widgets/custom_text_field.dart';
import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:flutter/material.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({
    required this.onChange,
    super.key,
  });

  final void Function(String username, String password) onChange;

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authScreenTheme = AuthScreenTheme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: authScreenTheme.textFiledPadding,
          child: CustomTextField(
            textEditingController: _usernameController,
            hintText: 'Username',
            onChanged: (_) => widget.onChange(
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
            obscureText: true,
            onChanged: (_) => widget.onChange(
              _usernameController.text,
              _passwordController.text,
            ),
          ),
        ),
      ],
    );
  }
}
