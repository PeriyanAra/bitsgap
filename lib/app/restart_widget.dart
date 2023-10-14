import 'package:flutter/widgets.dart';

typedef BeforeRestartCallback = Future<void> Function();

class RestartWidget extends StatefulWidget {
  const RestartWidget({
    super.key,
    required this.child,
    required this.onBeforeRestart,
  });

  final Widget child;
  final BeforeRestartCallback onBeforeRestart;

  static Future<void> restart(
    BuildContext context,
  ) async {
    await context.findAncestorStateOfType<RestartWidgetState>()!.restart();
  }

  @override
  State<RestartWidget> createState() => RestartWidgetState();
}

class RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  Future<void> restart() async {
    await widget.onBeforeRestart();

    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
