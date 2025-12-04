import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/widgets.dart';

void main() {
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
          home: Scaffold(
            appBar: const CustomHeader(),
            body: const Text('Current Page'),
          ),
          routes: {
            '/': (context) => const Scaffold(body: Text('Home Page')),
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
          home: Scaffold(
            appBar: const CustomHeader(),
            body: const Text('Current Page'),
          ),
          routes: {
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
          home: Scaffold(
            appBar: const CustomHeader(),
            body: const Text('Current Page'),
          ),
          routes: {
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
          home: Scaffold(
            appBar: const CustomHeader(),
            body: const Text('Current Page'),
          ),
          routes: {
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
          home: Scaffold(
            appBar: const CustomHeader(),
            body: const Text('Current Page'),
          ),
          routes: {
            '/': (context) => const Scaffold(body: Text('Home Page')),
          },
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
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
        MaterialApp(
          home: Scaffold(
            appBar: const CustomHeader(),
            body: const Text('Current Page'),
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
  });
}
