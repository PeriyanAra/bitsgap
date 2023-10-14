import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

typedef BlueberrySnackBarBuilder = Widget Function(
  BuildContext context,
);

class BitsgapSnackBarNotifier extends StatelessWidget {
  const BitsgapSnackBarNotifier({
    super.key,
    required this.child,
  });

  final Widget child;

  static BitsgapSnackBarNotifier of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_NotifierScope>();
    assert(scope != null, 'Could not find BlueberrySnackBarNotifier for given BuildContext');

    return scope!._notifier;
  }

  void show({
    required BlueberrySnackBarBuilder builder,
  }) {
    showOverlay(
      (context, t) {
        return Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.down,
                  child: BottomSlideNotification(
                    builder: (context) => builder(context),
                    progress:  t,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void hide({
    required BuildContext context,
  }) {
    OverlaySupportEntry.of(context)?.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: _NotifierScope(
        notifier: this,
        child: child,
      ),
    );
  }
}

class _NotifierScope extends InheritedWidget {
  const _NotifierScope({
    required super.child,
    required BitsgapSnackBarNotifier notifier,
  }) : _notifier = notifier;

  final BitsgapSnackBarNotifier _notifier;

  @override
  bool updateShouldNotify(_NotifierScope oldWidget) => oldWidget._notifier != _notifier;
}
