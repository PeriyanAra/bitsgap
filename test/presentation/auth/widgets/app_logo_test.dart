import 'package:bitsgap/presentation.dart';
import 'package:bitsgap/presentation/auth/widgets/app_logo.dart';
import 'package:bitsgap/presentation/theme/extensions/auth_screen_theme.dart';
import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockAuthScreenTheme extends Mock implements AuthScreenTheme {}

class MockAuthMobx extends Mock implements AuthMobx {}

void main() {
  testWidgets(
    'AppLogo widget test',
    (WidgetTester tester) async {
      final mockAuthScreenTheme = MockAuthScreenTheme();
      final mockAuthMobx = MockAuthMobx();

      await tester.pumpWidget(
        Provider(
          create: (_) => mockAuthMobx,
          child: MaterialApp(
            home: const AppLogo(),
            theme: BitsgapTheme.light(),
            darkTheme: BitsgapTheme.dark(),
          ),
        ),
      );

      when(() => mockAuthScreenTheme.logoSize).thenReturn(50.0);

      expect(find.byType(AppLogo), findsOneWidget);

      expect(find.byType(SvgPicture), findsOneWidget);

      final svgPicture = find.byType(SvgPicture).evaluate().first.widget as SvgPicture;
      expect(svgPicture.width, mockAuthScreenTheme.logoSize);
      expect(svgPicture.height, mockAuthScreenTheme.logoSize);
    },
  );
}
