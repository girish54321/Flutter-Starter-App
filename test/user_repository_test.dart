// // import 'package:flutter/foundation.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:get/get_navigation/src/root/get_material_app.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:mockito/annotations.dart';
// // import 'package:mockito/mockito.dart';
// // import 'package:reqres_app/App/auth/login/loginScreen.dart';
// // import 'package:reqres_app/l10n/app_localizations.dart';
// // import 'package:reqres_app/network/ReqResClient.dart';
// // import 'package:reqres_app/network/util/api_path.dart';
// // import 'package:reqres_app/network/util/request_type.dart';

// // import 'user_repository_test.mocks.dart';

// // @GenerateMocks([http.Client])
// // void main() {
// //   // group('description', () {
// //   //   test("description 1", () async {
// //   //     final client = MockClient();

// //   //     when(client.get(Uri.parse('https://reqres.in/api/users/2'))).thenAnswer(
// //   //         (_) async => http.Response(
// //   //             '{"data": {"id": 2, "email": "janet.weaver@reqres.in"}}', 200));

// //   //     expect(await client.get(Uri.parse('https://reqres.in/api/users/2')),
// //   //         isA<http.Response>());
// //   //   });
// //   // });

// //   testWidgets('LoginScreen validation and form test', (tester) async {
// //     // Build the LoginScreen inside a GetMaterialApp
// //     await tester.pumpWidget(
// //       GetMaterialApp(
// //         localizationsDelegates: AppLocalizations.localizationsDelegates,
// //         supportedLocales: AppLocalizations.supportedLocales,
// //         home: LoginScreen(),
// //       ),
// //     );

// //     await tester.pump(const Duration(seconds: 1));

// //     final client = MockClient();

// //     // Corrected 'when' stub to match all arguments
// //     when(client.post(
// //       Uri.parse('https://reqres.in/api/login'),
// //       headers: anyNamed('headers'),
// //       body: anyNamed('body'),
// //       encoding: anyNamed('encoding'),
// //     )).thenAnswer(
// //         (_) async => http.Response('{"token": "QpwL5tke4Pnpja7X4"}', 200));

// //     final emailInput = find.byKey(const Key('email-input-form'));
// //     final passwordInput = find.byKey(const Key('password-input-form'));
// //     final loginButton = find.byKey(const Key('login-button'));

// //     expect(emailInput, findsOneWidget);
// //     expect(passwordInput, findsOneWidget);
// //     expect(loginButton, findsOneWidget);

// //     // Test form validation for empty fields
// //     await tester.tap(loginButton);
// //     await tester.pump(const Duration(seconds: 1));
// //     expect(find.text('Email is required'), findsOneWidget);
// //     expect(find.text('Password is required'), findsOneWidget);

// //     // Enter valid text and submit
// //     await tester.enterText(emailInput, 'girish@gmail.com');
// //     await tester.enterText(passwordInput, '123456');
// //     await tester.tap(loginButton);
// //     await tester.pump(const Duration(seconds: 1));

// //     // Use 'verify' to check if the post method was called
// //     verify(client.post(
// //       Uri.parse('https://reqres.in/api/login'),
// //       headers: anyNamed('headers'),
// //       body: anyNamed('body'),
// //       encoding: anyNamed('encoding'),
// //     )).called(1);
// //   });
// // }

// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:reqres_app/App/auth/login/loginScreen.dart';
// import 'package:reqres_app/l10n/app_localizations.dart';
// import 'dart:convert';

// import 'package:reqres_app/network/ReqResClient.dart';
// import 'package:reqres_app/network/util/api_path.dart';
// import 'package:reqres_app/network/util/request_type.dart';

// class MockClient extends Mock implements http.Client {}

// void main() {
//   testWidgets('LoginScreen validation and form test', (tester) async {
//     // final client = MockClient();

//     // // Arrange: stub the POST method correctly
//     // when(
//     //   client.post(
//     //     Uri.parse('https://reqres.in/api/login'),
//     //     headers: anyNamed('headers'),
//     //     body: json.encode({'email': 'girish@gmail.com', 'password': '123456'}),
//     //   ),
//     // ).thenAnswer(
//     //   (_) async => http.Response('{"token": "QpwL5tke4Pnpja7X4"}', 200),
//     // );

//     // final client2 = ReqResClient(client);

//     // Optional: manually trigger API call (if needed for test)
//     final response = await client2.request(
//       requestType: RequestType.POST,
//       path: APIPathHelper.getValue(APIPath.login),
//       parameter: {'email': 'girish@gmail.com', 'password': '123456'},
//     );

//     expect(response, isNotNull);

//     // Build the LoginScreen inside a GetMaterialApp
//     await tester.pumpWidget(
//       GetMaterialApp(
//         localizationsDelegates: AppLocalizations.localizationsDelegates,
//         supportedLocales: AppLocalizations.supportedLocales,
//         home: LoginScreen(),
//       ),
//     );

//     await tester.pumpAndSettle();

//     final emailInput = find.byKey(const Key('email-input-form'));
//     final passwordInput = find.byKey(const Key('password-input-form'));
//     final loginButton = find.byKey(const Key('login-button'));

//     expect(emailInput, findsOneWidget);
//     expect(passwordInput, findsOneWidget);
//     expect(loginButton, findsOneWidget);

//     // Validate errors
//     await tester.tap(loginButton);
//     await tester.pumpAndSettle();

//     expect(find.text('Email is required'), findsOneWidget);
//     expect(find.text('Password is required'), findsOneWidget);

//     // Enter valid inputs
//     await tester.enterText(emailInput, 'girish@gmail.com');
//     await tester.enterText(passwordInput, '123456');

//     await tester.tap(loginButton);
//     await tester.pumpAndSettle();

//     // Assert response
//     verify(client.post(
//       Uri.parse('https://reqres.in/api/login'),
//       headers: anyNamed('headers'),
//       body: jsonEncode({
//         'email': 'girish@gmail.com',
//         'password': '123456',
//       }),
//       encoding: anyNamed('encoding'),
//     )).called(1);
//   });
// }

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  testWidgets('http', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final HttpClient client = HttpClient();
      final HttpClientRequest request =
          await client.getUrl(Uri.parse('https://google.com'));

      final HttpClientResponse response = await request.close();
      print(response.statusCode); // Should get 200
    });
  });

  testWidgets('http2', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final result = await get(Uri.parse('https://google.com'));
      print(result.statusCode); // Should get 200
    });
  });
}
