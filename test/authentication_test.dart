import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/authentication_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Suppress network image errors during tests
  final originalOnError = FlutterError.onError;

  setUpAll(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception is NetworkImageLoadException) {
        return;
      }
      if (details.library != 'image resource service') {
        originalOnError?.call(details);
      }
    };
  });

  tearDownAll(() {
    FlutterError.onError = originalOnError;
  });

  Widget createTestWidget() {
    return const MaterialApp(
      home: AuthenticatioScreen(),
    );
  }

  group('AuthenticatioScreen Tests', () {
    testWidgets('renders authentication screen', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(AuthenticatioScreen), findsOneWidget);
    });

    testWidgets('displays username field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Username'), findsOneWidget);
    });

    testWidgets('displays password field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('displays submit button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('username field accepts input', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final usernameFinder = find.widgetWithText(TextField, 'Username');
      await tester.enterText(usernameFinder, 'testuser');

      expect(find.text('testuser'), findsOneWidget);
    });

    testWidgets('password field accepts input', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final passwordFinder = find.widgetWithText(TextField, 'Password');
      await tester.enterText(passwordFinder, 'password123');

      // Password is obscured, so we check the TextField directly
      final TextField passwordField = tester.widget(passwordFinder);
      expect(passwordField.obscureText, true);
    });

    testWidgets('password field is obscured', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final passwordFinder = find.widgetWithText(TextField, 'Password');
      final TextField passwordField = tester.widget(passwordFinder);

      expect(passwordField.obscureText, true);
    });

    testWidgets('submit button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter username
      await tester.enterText(
          find.widgetWithText(TextField, 'Username'), 'testuser');

      // Enter password
      await tester.enterText(
          find.widgetWithText(TextField, 'Password'), 'password123');

      // Tap submit
      await tester.tap(find.text('Submit'));
      await tester.pump();

      // Verify snackbar appears
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Username: testuser, Password: password123'),
          findsOneWidget);
    });

    testWidgets('username field has border', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final TextField usernameField =
          tester.widget(find.widgetWithText(TextField, 'Username'));
      expect(usernameField.decoration?.border, isA<OutlineInputBorder>());
    });

    testWidgets('password field has border', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final TextField passwordField =
          tester.widget(find.widgetWithText(TextField, 'Password'));
      expect(passwordField.decoration?.border, isA<OutlineInputBorder>());
    });

    testWidgets('has custom header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('has footer', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('fields are centered vertically', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final Column column = tester.widget(find.byType(Column).first);
      expect(column.mainAxisAlignment, MainAxisAlignment.center);
    });

    testWidgets('has proper spacing between elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(SizedBox), findsAtLeastNWidgets(2));
    });

    testWidgets('submit button is ElevatedButton', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
    });

    testWidgets('has padding around content', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final Padding padding = tester.widget(find.byType(Padding).first);
      expect(padding.padding, const EdgeInsets.all(16.0));
    });

    testWidgets('username TextField has onChanged callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final TextField usernameField =
          tester.widget(find.widgetWithText(TextField, 'Username'));
      expect(usernameField.onChanged, isNotNull);
    });

    testWidgets('password TextField has onChanged callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final TextField passwordField =
          tester.widget(find.widgetWithText(TextField, 'Password'));
      expect(passwordField.onChanged, isNotNull);
    });

    testWidgets('submit shows empty values when fields are empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Tap submit without entering anything
      await tester.tap(find.text('Submit'));
      await tester.pump();

      // Snackbar should show empty strings
      expect(find.text('Username: , Password: '), findsOneWidget);
    });

    testWidgets('can enter special characters in username',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(
          find.widgetWithText(TextField, 'Username'), 'user@123.com');

      expect(find.text('user@123.com'), findsOneWidget);
    });

    testWidgets('submit button has onPressed callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final ElevatedButton button =
          tester.widget(find.widgetWithText(ElevatedButton, 'Submit'));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('username field has label text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final TextField field =
          tester.widget(find.widgetWithText(TextField, 'Username'));
      expect(field.decoration?.labelText, 'Username');
    });

    testWidgets('password field has label text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final TextField field =
          tester.widget(find.widgetWithText(TextField, 'Password'));
      expect(field.decoration?.labelText, 'Password');
    });

    testWidgets('has two TextFields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('snackbar disappears after duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(
          find.widgetWithText(TextField, 'Username'), 'test');
      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);

      // Wait for snackbar to disappear
      await tester.pump(const Duration(seconds: 5));
      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
