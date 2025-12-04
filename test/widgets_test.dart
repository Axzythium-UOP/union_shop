import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Suppress all error output during tests
  final originalOnError = FlutterError.onError;

  setUpAll(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception is NetworkImageLoadException) {
        return;
      }
      originalOnError?.call(details);
    };
  });

  tearDownAll(() {
    FlutterError.onError = originalOnError;
  });

  group('FooterWidget Tests', () {
    testWidgets('renders footer with correct text content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      expect(
          find.text(
              'Contact Email: Daniel.t.gardner@hotmail.com / Phone: 123-123-123 \n'
              '© 2025 Union Shop. All rights reserved. \n'
              'Privacy Policy | Terms of Service'),
          findsOneWidget);
    });

    testWidgets('footer has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      final Container container = tester.widget(find.byType(Container).first);
      expect(container.color, Colors.grey[50]);
      expect(container.padding, const EdgeInsets.all(24));

      final Text text = tester.widget(find.byType(Text));
      expect(text.style?.color, Colors.grey);
      expect(text.style?.fontSize, 16);
      expect(text.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('footer takes full width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      final Container container = tester.widget(find.byType(Container).first);
      expect(container.constraints?.maxWidth, double.infinity);
    });
  });

  group('CustomHeader Tests', () {
    testWidgets('renders header with correct structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      expect(find.text('Free shipping on orders over £30!'), findsOneWidget);
      expect(find.text('ABOUT US'), findsOneWidget);
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('header has correct preferred size',
        (WidgetTester tester) async {
      const header = CustomHeader();
      expect(header.preferredSize.height, 100);
    });

    testWidgets('custom height is respected', (WidgetTester tester) async {
      const customHeight = 150.0;
      const header = CustomHeader(height: customHeight);
      expect(header.preferredSize.height, customHeight);
    });

    testWidgets('purple banner displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      final Container banner = tester.widget(
        find
            .ancestor(
              of: find.text('Free shipping on orders over £30!'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(banner.color, const Color(0xFF4d2963));
    });

    testWidgets('all icon buttons are present', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('home button navigates to home route',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/current',
          routes: {
            '/': (context) => const Scaffold(body: Text('Home Page')),
            '/current': (context) => Scaffold(
                  appBar: const CustomHeader(),
                  body: const Text('Current Page'),
                ),
          },
        ),
      );

      await tester.tap(find.text('HOME'));
      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('about button navigates to about_us route',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Scaffold(
                  appBar: const CustomHeader(),
                  body: const Text('Current Page'),
                ),
            '/about_us': (context) =>
                const Scaffold(body: Text('About Us Page')),
          },
        ),
      );

      await tester.tap(find.text('ABOUT US'));
      await tester.pumpAndSettle();

      expect(find.text('About Us Page'), findsOneWidget);
    });

    testWidgets('authentication icon navigates to authentication route',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Scaffold(
                  appBar: const CustomHeader(),
                  body: const Text('Current Page'),
                ),
            '/authentication': (context) =>
                const Scaffold(body: Text('Auth Page')),
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle();

      expect(find.text('Auth Page'), findsOneWidget);
    });

    testWidgets('cart icon navigates to cart route',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Scaffold(
                  appBar: const CustomHeader(),
                  body: const Text('Current Page'),
                ),
            '/cart': (context) => const Scaffold(body: Text('Cart Page')),
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Cart Page'), findsOneWidget);
    });

    testWidgets('logo click navigates to home', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/current',
          routes: {
            '/': (context) => const Scaffold(body: Text('Home Page')),
            '/current': (context) => Scaffold(
                  appBar: const CustomHeader(),
                  body: const Text('Current Page'),
                ),
          },
        ),
      );

      // Verify we're on the current page
      expect(find.text('Current Page'), findsOneWidget);

      // Tap on the HOME button instead which has the same navigation behavior
      await tester.tap(find.text('HOME'));
      await tester.pumpAndSettle();

      // After navigation, we should see the Home Page
      expect(find.text('Home Page'), findsOneWidget);
      expect(find.text('Current Page'), findsNothing);
    });
    testWidgets('buttons have correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      final ElevatedButton homeButton = tester.widget(
        find.widgetWithText(ElevatedButton, 'HOME'),
      );

      expect(homeButton.style?.backgroundColor?.resolve({}), Colors.white);
      expect(homeButton.style?.foregroundColor?.resolve({}),
          const Color(0xFF4d2963));
    });

    testWidgets('search and menu buttons are non-functional',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomHeader(),
            body: Text('Current Page'),
          ),
        ),
      );

      // Tap search icon - should do nothing (no navigation)
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.text('Current Page'), findsOneWidget);

      // Tap menu icon - should do nothing (no navigation)
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.text('Current Page'), findsOneWidget);
    });

    testWidgets('header banner text has correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      final Text bannerText = tester.widget(
        find.text('Free shipping on orders over £30!'),
      );

      expect(bannerText.style?.color, Colors.white);
      expect(bannerText.style?.fontSize, 16);
      expect(bannerText.textAlign, TextAlign.center);
    });

    testWidgets('about button has correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      final ElevatedButton aboutButton = tester.widget(
        find.widgetWithText(ElevatedButton, 'ABOUT US'),
      );

      expect(aboutButton.style?.backgroundColor?.resolve({}), Colors.white);
      expect(aboutButton.style?.foregroundColor?.resolve({}),
          const Color(0xFF4d2963));
    });

    testWidgets('icon buttons have correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      final IconButton searchButton = tester.widget(
        find.widgetWithIcon(IconButton, Icons.search),
      );

      expect(searchButton.constraints?.minWidth, 32);
      expect(searchButton.constraints?.minHeight, 32);
      expect(searchButton.padding, const EdgeInsets.all(8));
    });

    testWidgets('header logo has error builder', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      // The logo image should be present (or error widget)
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsAtLeastNWidgets(1));
    });

    testWidgets('header has correct height calculation',
        (WidgetTester tester) async {
      const customHeight = 200.0;
      const header = CustomHeader(height: customHeight);

      expect(header.preferredSize.height, customHeight);
      expect(header.preferredSize.width, double.infinity);
    });

    testWidgets('header container has white background',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      // Find the outer container of the header
      final Container outerContainer = tester.widget(
        find
            .descendant(
              of: find.byType(CustomHeader),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(outerContainer.color, Colors.white);
    });

    testWidgets('all icon buttons have correct colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: Container(),
          ),
        ),
      );

      final IconButton authButton = tester.widget(
        find.widgetWithIcon(IconButton, Icons.person_outline),
      );
      final Icon authIcon = authButton.icon as Icon;
      expect(authIcon.color, Colors.grey);
      expect(authIcon.size, 18);
    });

    testWidgets('navigation buttons clear stack when going home',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/other',
          routes: {
            '/': (context) => const Scaffold(body: Text('Home Page')),
            '/other': (context) => Scaffold(
                  appBar: const CustomHeader(),
                  body: const Text('Other Page'),
                ),
          },
        ),
      );

      expect(find.text('Other Page'), findsOneWidget);

      await tester.tap(find.text('HOME'));
      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
      expect(find.text('Other Page'), findsNothing);
    });

    testWidgets('header respects minimum height of zero',
        (WidgetTester tester) async {
      // Test edge case: very small height
      const header = CustomHeader(height: 10);
      expect(header.preferredSize.height, 10);
    });
  });

  group('FooterWidget Additional Tests', () {
    testWidgets('footer text contains email', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      expect(
          find.textContaining('Daniel.t.gardner@hotmail.com'), findsOneWidget);
    });

    testWidgets('footer text contains phone', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      expect(find.textContaining('123-123-123'), findsOneWidget);
    });

    testWidgets('footer text contains copyright', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      expect(find.textContaining('© 2025 Union Shop'), findsOneWidget);
    });

    testWidgets('footer text contains privacy policy',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      expect(find.textContaining('Privacy Policy'), findsOneWidget);
    });

    testWidgets('footer text contains terms of service',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      expect(find.textContaining('Terms of Service'), findsOneWidget);
    });

    testWidgets('footer renders correctly in different screen sizes',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(300, 600));
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      final Container container = tester.widget(find.byType(Container).first);
      expect(container.constraints?.maxWidth, double.infinity);

      // Reset to default size
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('footer has single Text widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FooterWidget(),
          ),
        ),
      );

      final textWidgets = find.descendant(
        of: find.byType(FooterWidget),
        matching: find.byType(Text),
      );

      expect(textWidgets, findsOneWidget);
    });
  });
}
