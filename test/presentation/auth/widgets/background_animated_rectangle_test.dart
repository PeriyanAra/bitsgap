import 'package:bitsgap/presentation/auth/mobx/auth_mobx.dart';
import 'package:bitsgap/presentation/auth/widgets/background_animated_rectangle.dart';
import 'package:bitsgap/presentation/theme/bitsgap_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockAuthMobx extends Mock implements AuthMobx {}

void main() {
  testWidgets(
    'BackgroundAnimatedRectangle Widget Test',
    (WidgetTester tester) async {
      final mockAuthMobx = MockAuthMobx();

      await tester.pumpWidget(
        Provider(
          create: (_) => mockAuthMobx,
          child: MaterialApp(
            home: const BackgroundAnimatedRectangle(),
            theme: BitsgapTheme.light(),
            darkTheme: BitsgapTheme.dark(),
          ),
        ),
      );

      final backgroundWidget = find.byType(BackgroundAnimatedRectangle);

      expect(backgroundWidget, findsOneWidget);

      final animatedBuilderWidget =
          find.descendant(of: backgroundWidget, matching: find.byType(AnimatedBuilder));

      expect(backgroundWidget, findsOneWidget);

      expect(animatedBuilderWidget, findsOneWidget);
      expect(find.byType(Transform), findsOneWidget);
      expect(find.byType(DecoratedBox), findsOneWidget);
    },
  );
}
