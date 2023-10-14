import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.hintStyle,
    this.borderRadius,
    this.obscureText = false,
    this.borderSide,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.textEditingController,
    this.hasError = false,
    this.inputType,
    this.textInputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool hasError;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final List<TextInputFormatter>? textInputFormatters;
  final TextCapitalization textCapitalization;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textEditingController;
  late FocusNode _inputFocusNode;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _inputFocusNode = widget.focusNode ?? FocusNode();

    _textEditingController = widget.textEditingController ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final bitsgapInputFieldTheme = BitsgapInputFieldTheme.of(context);

    return TextFormField(
      keyboardType: widget.inputType,
      controller: _textEditingController,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      onTap: () => _onInputTap,
      inputFormatters: widget.textInputFormatters,
      textCapitalization: widget.textCapitalization,
      style: widget.hintStyle ?? bitsgapInputFieldTheme.defaultTextStyle,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(
          horizontal: bitsgapInputFieldTheme.horizontalPadding,
          vertical: bitsgapInputFieldTheme.verticalPadding,
        ),
        border: InputBorder.none,
        hintStyle: widget.hintStyle ?? bitsgapInputFieldTheme.defaultTextStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? bitsgapInputFieldTheme.borderRadius,
          borderSide: widget.borderSide ??
              BorderSide(
                color: widget.hasError
                    ? bitsgapInputFieldTheme.colorTheme.error
                    : bitsgapInputFieldTheme.colorTheme.primary,
                width: bitsgapInputFieldTheme.borderWidth,
              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? bitsgapInputFieldTheme.borderRadius,
          borderSide: widget.borderSide ??
              BorderSide(
                color: widget.hasError
                    ? bitsgapInputFieldTheme.colorTheme.error
                    : bitsgapInputFieldTheme.colorTheme.primary.withOpacity(0.5),
                width: bitsgapInputFieldTheme.borderWidth,
              ),
        ),
      ),
    );
  }

  void _onInputTap() {
    widget.onTap?.call();
    _inputFocusNode.requestFocus();
  }
}
