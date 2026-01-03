import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:reqres_app/App/auth/login/loginScreen.dart';
import 'package:reqres_app/l10n/app_localizations.dart';

void main() {
  testWidgets('LoginScreen validation and form test', (tester) async {
    // Build the LoginScreen inside a GetMaterialApp
    await tester.pumpWidget(
      GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Find inputs and button
    final emailInput = find.byKey(const Key('email-input')); // FIXED TYPO
    final passwordInput = find.byKey(const Key('password-input-form'));
    final loginButton = find.byKey(const Key('login-button'));

    expect(emailInput, findsOneWidget);
    expect(passwordInput, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Submit with empty fields
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);

    // Fill in valid values
    await tester.enterText(emailInput, 'girish@gmail.com');
    await tester.enterText(passwordInput, '123456');

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Errors should disappear
    expect(find.text('Email is required'), findsNothing);
    expect(find.text('Password is required'), findsNothing);
  });
}
