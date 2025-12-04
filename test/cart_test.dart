import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/views/cart.dart';
import 'package:union_shop/models/cart_item.dart';

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

  Widget createTestWidget(CartProvider provider) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: const MaterialApp(
        home: CartScreen(),
      ),
    );
  }

  group('CartProvider Tests', () {
    test('initial cart is empty', () {
      final provider = CartProvider();
      expect(provider.items.isEmpty, true);
      expect(provider.itemCount, 0);
      expect(provider.totalPrice, 0.0);
    });

    test('addItem adds item to cart', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      expect(provider.itemCount, 1);
      expect(provider.items.values.first.title, 'Test Product');
      expect(provider.items.values.first.quantity, 1);
    });

    test('addItem with quantity adds multiple', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 3,
      );

      expect(provider.items.values.first.quantity, 3);
    });

    test('addItem combines same items', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 2,
      );
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 1,
      );

      expect(provider.itemCount, 1);
      expect(provider.items.values.first.quantity, 3);
    });

    test('addItem creates separate items for different sizes', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'L',
        color: 'Blue',
        price: 10.0,
      );

      expect(provider.itemCount, 2);
    });

    test('addItem creates separate items for different colors', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Red',
        price: 10.0,
      );

      expect(provider.itemCount, 2);
    });

    test('removeItem removes item from cart', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      final id = provider.items.keys.first;
      provider.removeItem(id);

      expect(provider.itemCount, 0);
    });

    test('clear removes all items', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Product 1',
        imageUrl: 'test1.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );
      provider.addItem(
        title: 'Product 2',
        imageUrl: 'test2.jpg',
        size: 'L',
        color: 'Red',
        price: 15.0,
      );

      provider.clear();

      expect(provider.itemCount, 0);
      expect(provider.items.isEmpty, true);
    });

    test('increaseQuantity increases item quantity', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      final id = provider.items.keys.first;
      provider.increaseQuantity(id);

      expect(provider.items.values.first.quantity, 2);
    });

    test('increaseQuantity by custom amount', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      final id = provider.items.keys.first;
      provider.increaseQuantity(id, 5);

      expect(provider.items.values.first.quantity, 6);
    });

    test('decreaseQuantity decreases item quantity', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 3,
      );

      final id = provider.items.keys.first;
      provider.decreaseQuantity(id);

      expect(provider.items.values.first.quantity, 2);
    });

    test('decreaseQuantity removes item when quantity reaches zero', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 1,
      );

      final id = provider.items.keys.first;
      provider.decreaseQuantity(id);

      expect(provider.itemCount, 0);
    });

    test('totalPrice calculates correctly', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Product 1',
        imageUrl: 'test1.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 2,
      );
      provider.addItem(
        title: 'Product 2',
        imageUrl: 'test2.jpg',
        size: 'L',
        color: 'Red',
        price: 15.0,
        quantity: 1,
      );

      expect(provider.totalPrice, 35.0);
    });

    test('totalPrice updates after quantity change', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      final id = provider.items.keys.first;
      provider.increaseQuantity(id, 2);

      expect(provider.totalPrice, 30.0);
    });

    test('items getter returns copy', () {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      final items = provider.items;
      items.clear();

      expect(provider.itemCount, 1);
    });
  });

  group('CartItem Tests', () {
    test('CartItem creates with required fields', () {
      final item = CartItem(
        id: '1',
        title: 'Test',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      expect(item.id, '1');
      expect(item.title, 'Test');
      expect(item.quantity, 1);
    });

    test('CartItem creates with custom quantity', () {
      final item = CartItem(
        id: '1',
        title: 'Test',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 5,
      );

      expect(item.quantity, 5);
    });

    test('CartItem quantity can be modified', () {
      final item = CartItem(
        id: '1',
        title: 'Test',
        imageUrl: 'test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      item.quantity = 3;
      expect(item.quantity, 3);
    });
  });

  group('CartScreen Widget Tests', () {
    testWidgets('displays empty cart message when cart is empty',
        (WidgetTester tester) async {
      final provider = CartProvider();
      await tester.pumpWidget(createTestWidget(provider));

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('displays cart title', (WidgetTester tester) async {
      final provider = CartProvider();
      await tester.pumpWidget(createTestWidget(provider));

      expect(find.text('Your Cart'), findsOneWidget);
    });

    testWidgets('displays items when cart has items',
        (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Size: M • Blue'), findsOneWidget);
    });

    testWidgets('displays item price', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 15.50,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('£15.50'), findsOneWidget);
    });

    testWidgets('displays total price', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Product 1',
        imageUrl: 'https://example.com/test1.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );
      provider.addItem(
        title: 'Product 2',
        imageUrl: 'https://example.com/test2.jpg',
        size: 'L',
        color: 'Red',
        price: 15.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('£25.00'), findsOneWidget);
    });

    testWidgets('displays continue shopping button',
        (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('Continue Shopping'), findsOneWidget);
    });

    testWidgets('displays checkout button', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('Checkout'), findsOneWidget);
    });

    testWidgets('checkout button clears cart', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();

      expect(provider.itemCount, 0);
      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('displays quantity controls', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('-'), findsOneWidget);
      expect(find.text('+'), findsOneWidget);
    });

    testWidgets('increase quantity button works', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      // Find and tap the + button
      await tester.tap(find.text('+'));
      await tester.pumpAndSettle();

      expect(provider.items.values.first.quantity, 2);
    });

    testWidgets('decrease quantity button works', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
        quantity: 3,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      // Find and tap the - button
      await tester.tap(find.text('-'));
      await tester.pumpAndSettle();

      expect(provider.items.values.first.quantity, 2);
    });

    testWidgets('remove button removes item', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      // Find and tap the delete icon
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      expect(provider.itemCount, 0);
      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('displays multiple items', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Product 1',
        imageUrl: 'https://example.com/test1.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );
      provider.addItem(
        title: 'Product 2',
        imageUrl: 'https://example.com/test2.jpg',
        size: 'L',
        color: 'Red',
        price: 15.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('Product 2'), findsOneWidget);
    });

    testWidgets('total updates when quantity changes',
        (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 12.5,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('£12.50'), findsOneWidget);

      // Increase quantity
      await tester.tap(find.text('+'));
      await tester.pumpAndSettle();

      expect(find.text('£25.00'), findsOneWidget);
    });

    testWidgets('has back button in app bar', (WidgetTester tester) async {
      final provider = CartProvider();
      await tester.pumpWidget(createTestWidget(provider));

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('cart items have images', (WidgetTester tester) async {
      final provider = CartProvider();
      provider.addItem(
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        size: 'M',
        color: 'Blue',
        price: 10.0,
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsWidgets);
    });
  });
}
