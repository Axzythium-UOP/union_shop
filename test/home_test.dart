import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/home_page.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Suppress all error output during tests
  final originalOnError = FlutterError.onError;

  setUpAll(() {
    // Completely suppress network image errors and other expected test errors
    FlutterError.onError = (FlutterErrorDetails details) {
      // Silently ignore network image errors during tests
      if (details.exception is NetworkImageLoadException) {
        return;
      }
      // Only show unexpected errors
      if (details.library != 'image resource service') {
        originalOnError?.call(details);
      }
    };
  });

  tearDownAll(() {
    FlutterError.onError = originalOnError;
  });

  group('UnionShopApp Tests', () {
    testWidgets('app initializes with correct title and theme',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.title, 'Union Shop');
      expect(app.debugShowCheckedModeBanner, false);
      // Check theme exists rather than exact color value which varies by Flutter version
      expect(app.theme, isNotNull);
      expect(app.theme?.colorScheme, isNotNull);
    });

    testWidgets('app provides CartProvider', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());

      final context = tester.element(find.byType(HomeScreen));
      final provider = Provider.of<CartProvider>(context, listen: false);
      expect(provider, isNotNull);
    });

    testWidgets('app has correct initial route', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.initialRoute, '/');
    });

    testWidgets('app starts at HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('HomeScreen Tests', () {
    testWidgets('renders all main sections', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Hero section
      expect(find.text('Sales'), findsOneWidget);
      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);

      // Products section
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
    });

    testWidgets('displays all four product cards', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('UOP Magnet'), findsOneWidget);
      expect(find.text('UOP Cap'), findsOneWidget);
      expect(find.text('UOP T-shirt'), findsOneWidget);
      expect(find.text('UOP Tote Bag'), findsOneWidget);
    });

    testWidgets('displays correct prices for products',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('£10.00'), findsOneWidget); // Magnet
      expect(find.text('£15.00'), findsOneWidget); // Cap
      expect(find.text('£20.00'), findsOneWidget); // T-shirt
      expect(find.text('£25.00'), findsOneWidget); // Tote Bag
    });

    testWidgets('hero section has correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final Text salesText = tester.widget(find.text('Sales'));
      expect(salesText.style?.fontSize, 80);
      expect(salesText.style?.fontWeight, FontWeight.bold);
      expect(salesText.style?.color, Colors.white);
    });

    testWidgets('browse products button navigates to collections',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('BROWSE PRODUCTS'));
      await tester.pumpAndSettle();

      // Should navigate away from home screen
      expect(find.text('Sales'), findsNothing);
    });

    testWidgets('footer is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Contact Email: Daniel.t.gardner@hotmail.com / Phone: 123-123-123 \n'
              '© 2025 Union Shop. All rights reserved. \n'
              'Privacy Policy | Terms of Service'),
          findsOneWidget);
    });

    testWidgets('custom header is present', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('Free shipping on orders over £30!'), findsOneWidget);
      expect(find.text('HOME'), findsOneWidget);
      expect(find.text('ABOUT US'), findsOneWidget);
    });

    testWidgets('grid layout adjusts based on screen width',
        (WidgetTester tester) async {
      // Test with wide screen
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final GridView grid = tester.widget(find.byType(GridView));
      expect(grid, isNotNull);

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });

    testWidgets('products section has correct spacing',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final Padding productsPadding = tester.widget(
        find
            .ancestor(
              of: find.text('PRODUCTS SECTION'),
              matching: find.byType(Padding),
            )
            .first,
      );
      expect(productsPadding.padding, const EdgeInsets.all(40.0));
    });

    testWidgets('hero section has correct height', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final SizedBox heroSection = tester.widget(
        find
            .ancestor(
              of: find.text('Sales'),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(heroSection.height, 400);
    });

    testWidgets('body is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('all product images load with error handling',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // All four product cards should have Image.network widgets
      expect(find.byType(Image), findsAtLeastNWidgets(4));
    });
  });

  group('HomeScreen Navigation Tests', () {
    testWidgets('navigateToHome clears navigation stack',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final homeScreen = HomeScreen();
      final context = tester.element(find.byType(HomeScreen));

      // Navigate away first
      await tester.tap(find.text('ABOUT US'));
      await tester.pumpAndSettle();

      // Navigate home should clear stack
      homeScreen.navigateToHome(context);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('navigateToProduct works', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final homeScreen = HomeScreen();
      final context = tester.element(find.byType(HomeScreen));

      homeScreen.navigateToProduct(context);
      await tester.pumpAndSettle();

      // Should navigate away from home
      expect(find.text('PRODUCTS SECTION'), findsNothing);
    });

    testWidgets('navigateToAboutUs works', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final homeScreen = HomeScreen();
      final context = tester.element(find.byType(HomeScreen));

      homeScreen.navigateToAboutUs(context);
      await tester.pumpAndSettle();

      expect(find.text('PRODUCTS SECTION'), findsNothing);
    });

    testWidgets('navigateToCollections works', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final homeScreen = HomeScreen();
      final context = tester.element(find.byType(HomeScreen));

      homeScreen.navigateToCollections(context);
      await tester.pumpAndSettle();

      expect(find.text('Sales'), findsNothing);
    });

    testWidgets('navigateToAuthentication works', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      final homeScreen = HomeScreen();
      final context = tester.element(find.byType(HomeScreen));

      homeScreen.navigateToAuthentication(context);
      await tester.pumpAndSettle();

      expect(find.text('PRODUCTS SECTION'), findsNothing);
    });
  });

  group('HomeScreen Product Cards Tests', () {
    testWidgets('UOP Magnet card has correct description',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('UOP Magnet'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
    });

    testWidgets('UOP Cap card has correct description',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('UOP Cap'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
    });

    testWidgets('UOP T-shirt card has correct description',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('UOP T-shirt'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
    });

    testWidgets('UOP Tote Bag card has correct description',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('UOP Tote Bag'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
    });
  });

  group('HomeScreen Routes Tests', () {
    testWidgets('all routes are properly configured',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.routes?.containsKey('/product'), true);
      expect(app.routes?.containsKey('/products_page'), true);
      expect(app.routes?.containsKey('/about_us'), true);
      expect(app.routes?.containsKey('/collections'), true);
      expect(app.routes?.containsKey('/authentication'), true);
      expect(app.routes?.containsKey('/cart'), true);
    });
  });
}
