import 'package:bitsgap/presentation/theme/extensions/snack_bar_theme.dart';
import 'package:bitsgap/presentation/theme/images.dart';
import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:bitsgap/presentation/ui_kit/snack_bar/bitsgap_snack_bar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BitsgapSnackBar {
  BitsgapSnackBar.error(this.message) : _type = _BitsgapSnackBarType.error;

  BitsgapSnackBar.success(
    this.message,
  ) : _type = _BitsgapSnackBarType.success;

  final String message;
  final _BitsgapSnackBarType _type;

  Widget call(BuildContext context) {
    final colorTheme = BitsgapColorTheme.of(context);
    final snackBarColor = _snackBarColor(colorTheme);
    final snackBarPrefixIconPath = _snackBarPrefixIconPath();
    final snackBarTitle = _snackBarTile();
    final snackBarTheme = SnackBarTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: snackBarTheme.snackBarRadius,
        color: snackBarColor,
      ),
      margin: snackBarTheme.snackBarMargin,
      padding: snackBarTheme.snackBarPadding,
      child: Row(
        children: [
          SvgPicture.asset(snackBarPrefixIconPath),
          SizedBox(
            width: snackBarTheme.snackBarPrefixIconHorizontalSpacing,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snackBarTitle,
                  style: snackBarTheme.titleTextStyle,
                ),
                Text(
                  message,
                  style: snackBarTheme.messageTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: context.hideSnackBar,
            child: Padding(
              padding: snackBarTheme.snackBarSuffixIconPadding,
              child: SvgPicture.asset(Images.close),
            ),
          ),
        ],
      ),
    );
  }

  BitsgapColor _snackBarColor(BitsgapColorTheme colorTheme) {
    switch (_type) {
      case _BitsgapSnackBarType.error:
        return colorTheme.error;
      case _BitsgapSnackBarType.success:
        return colorTheme.success;
    }
  }

  String _snackBarPrefixIconPath() {
    switch (_type) {
      case _BitsgapSnackBarType.error:
        return Images.errorCircle;
      case _BitsgapSnackBarType.success:
        return Images.checkCircle;
    }
  }

  String _snackBarTile() {
    switch (_type) {
      case _BitsgapSnackBarType.error:
        return 'Error!';
      case _BitsgapSnackBarType.success:
        return 'Well done!';
    }
  }
}

enum _BitsgapSnackBarType {
  error,
  success,
}

extension BitsgapSnackbarBuildContextExtensions on BuildContext {
  void showSuccessSnackBar(
    String message,
  ) =>
      BitsgapSnackBarNotifier.of(this).show(
        builder: BitsgapSnackBar.success(
          message,
        ),
      );

  void showErrorSnackBar(
    String message,
  ) =>
      BitsgapSnackBarNotifier.of(this).show(
        builder: BitsgapSnackBar.error(
          message,
        ),
      );

  void hideSnackBar() => BitsgapSnackBarNotifier.of(this).hide(
        context: this,
      );
}
