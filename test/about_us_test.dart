import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about_us.dart';

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
      home: AboutUsScreen(),
    );
  }

  group('AboutUsScreen Tests', () {
    testWidgets('renders about us screen', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(AboutUsScreen), findsOneWidget);
    });

    testWidgets('displays about us text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('This is for the About Us page.'), findsOneWidget);
    });

    testWidgets('text is centered', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('has custom header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('has footer', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('has scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('text widget exists in body', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final textWidget = find.descendant(
        of: find.byType(Center),
        matching: find.byType(Text),
      );

      expect(textWidget, findsOneWidget);
    });

    testWidgets('page renders without errors', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('has const constructor', (WidgetTester tester) async {
      const screen = AboutUsScreen();
      expect(screen, isA<AboutUsScreen>());
    });

    testWidgets('screen is a StatelessWidget', (WidgetTester tester) async {
      const screen = AboutUsScreen();
      expect(screen, isA<StatelessWidget>());
    });
  });
}
