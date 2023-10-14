import 'package:bitsgap/app/app_theme_mode/app_theme_mode.dart';
import 'package:bitsgap/presentation/auth/widgets/auth_buttons_section.dart';
import 'package:bitsgap/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('AuthButtonsSection Widget Test', () {
    testWidgets('Renders AuthButtonsSection correctly', (WidgetTester tester) async {
      final pageController = PageController();
      const loginSelected = true;
      const signUpSelected = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AppThemeMode>(
            create: (context) => AppThemeMode(), // Mock AppThemeMode
            child: MaterialApp(
              home: PageView(
                controller: pageController,
                children: [
                  AuthButtonsSection(
                    pageController: pageController,
                    onLogin: () {},
                    onSignUp: () {},
                  ),
                ],
              ),
              theme: BitsgapTheme.light(),
              darkTheme: BitsgapTheme.dark(),
            ),
          ),
        ),
      );

      expect(find.text('Login'), findsOneWidget);

      expect(find.text('Sign-up'), findsOneWidget);

      expect(loginSelected, isTrue);
      expect(signUpSelected, isFalse);

      await tester.tap(find.text('Sign-up'));
      await tester.pump();

      expect(loginSelected, isTrue);
      expect(signUpSelected, isFalse);
    });
  });
}
