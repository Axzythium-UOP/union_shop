import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/views/product_page.dart';

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

  Widget createTestWidget(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('ProductPage Tests', () {
    testWidgets('renders with default values', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.text('UOP Cap'), findsOneWidget);
      expect(find.text('£9.00'), findsOneWidget);
    });

    testWidgets('renders with custom values', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductPage(
            title: 'Test Product',
            price: '£15.00',
            description: 'Test description',
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('Test description'), findsOneWidget);
    });

    testWidgets('displays product image', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('displays size dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.text('Size'), findsOneWidget);
      expect(find.text('S'), findsOneWidget);
    });

    testWidgets('displays color dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.text('Color'), findsOneWidget);
      expect(find.text('Purple'), findsOneWidget);
    });

    testWidgets('displays quantity dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.text('Qty'), findsOneWidget);
      expect(find.text('1'), findsWidgets);
    });

    testWidgets('can change size', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      // Find and tap the size dropdown
      await tester.tap(find.text('S'));
      await tester.pumpAndSettle();

      // Select 'M'
      await tester.tap(find.text('M').last);
      await tester.pumpAndSettle();

      expect(find.text('M'), findsWidgets);
    });

    testWidgets('can change color', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      // Find and tap the color dropdown
      await tester.tap(find.text('Purple'));
      await tester.pumpAndSettle();

      // Select 'Navy'
      await tester.tap(find.text('Navy').last);
      await tester.pumpAndSettle();

      expect(find.text('Navy'), findsWidgets);
    });

    testWidgets('can change quantity', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      // Find all widgets with text '1' (quantity dropdown)
      final quantityDropdowns = find.text('1');

      // Tap the first one (the quantity dropdown button)
      await tester.tap(quantityDropdowns.first);
      await tester.pumpAndSettle();

      // Select '2' from the dropdown menu
      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      expect(find.text('2'), findsWidgets);
    });

    testWidgets('displays add to cart button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.text('Add to cart'), findsOneWidget);
    });

    testWidgets('add to cart button adds item to cart',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      // Tap add to cart
      await tester.tap(find.text('Add to cart'));
      await tester.pump();

      // Verify snackbar appears (may contain "added to cart")
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('add to cart with custom quantity',
        (WidgetTester tester) async {
      final provider = CartProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: const MaterialApp(
            home: ProductPage(),
          ),
        ),
      );

      // Change quantity to 3
      await tester.tap(find.text('1').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('3').last);
      await tester.pumpAndSettle();

      // Add to cart
      await tester.tap(find.text('Add to cart'));
      await tester.pumpAndSettle();

      // Verify cart has item with quantity 3
      expect(provider.items.length, 1);
      expect(provider.items.values.first.quantity, 3);
    });

    testWidgets('displays product description section',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.text('Product Description'), findsOneWidget);
    });

    testWidgets('add to cart button has correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      final ElevatedButton button = tester.widget(
        find.widgetWithText(ElevatedButton, 'Add to cart'),
      );

      expect(
          button.style?.backgroundColor?.resolve({}), const Color(0xFF4d2963));
    });

    testWidgets('page has footer', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('page has custom header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('size dropdown has all options', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      await tester.tap(find.text('S'));
      await tester.pumpAndSettle();

      expect(find.text('S'), findsWidgets);
      expect(find.text('M'), findsWidgets);
      expect(find.text('L'), findsWidgets);
      expect(find.text('XL'), findsWidgets);
    });

    testWidgets('color dropdown has all options', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      await tester.tap(find.text('Purple'));
      await tester.pumpAndSettle();

      expect(find.text('Purple'), findsWidgets);
      expect(find.text('Navy'), findsWidgets);
      expect(find.text('White'), findsWidgets);
    });

    testWidgets('quantity dropdown has 10 options',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      await tester.tap(find.text('1').first);
      await tester.pumpAndSettle();

      // Check for various quantities
      expect(find.text('5'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('page is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('product title has correct style', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      final Text titleText = tester.widget(find.text('UOP Cap'));
      expect(titleText.style?.fontSize, 22);
      expect(titleText.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('price has correct style and color',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProductPage()));

      final Text priceText = tester.widget(find.text('£9.00'));
      expect(priceText.style?.fontSize, 18);
      expect(priceText.style?.color, const Color(0xFF4d2963));
      expect(priceText.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('image has error builder', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductPage(
            imageUrl: 'invalid_url',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Error builder should show icon
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });

    testWidgets('adding same item multiple times increases quantity',
        (WidgetTester tester) async {
      final provider = CartProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: const MaterialApp(
            home: ProductPage(),
          ),
        ),
      );

      // Add to cart twice
      await tester.tap(find.text('Add to cart'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add to cart'));
      await tester.pumpAndSettle();

      // Should have one item with quantity 2
      expect(provider.items.length, 1);
      expect(provider.items.values.first.quantity, 2);
    });

    testWidgets('different sizes create separate cart items',
        (WidgetTester tester) async {
      final provider = CartProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: const MaterialApp(
            home: ProductPage(),
          ),
        ),
      );

      // Add size S
      await tester.tap(find.text('Add to cart'));
      await tester.pumpAndSettle();

      // Change to size M
      await tester.tap(find.text('S'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('M').last);
      await tester.pumpAndSettle();

      // Add size M
      await tester.tap(find.text('Add to cart'));
      await tester.pumpAndSettle();

      // Should have two separate items
      expect(provider.items.length, 2);
    });

    testWidgets('price parsing works correctly', (WidgetTester tester) async {
      final provider = CartProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: const MaterialApp(
            home: ProductPage(price: '£25.99'),
          ),
        ),
      );

      await tester.tap(find.text('Add to cart'));
      await tester.pumpAndSettle();

      expect(provider.items.values.first.price, 25.99);
    });
  });
}
