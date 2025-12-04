import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/views/products_page.dart';
import 'package:union_shop/widgets/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Suppress network image errors during tests
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

  Widget createTestWidget() {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MaterialApp(
        home: ProductsPageScreen(),
      ),
    );
  }

  group('ProductsPageScreen Tests', () {
    testWidgets('renders products page screen', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ProductsPageScreen), findsOneWidget);
    });

    testWidgets('displays PRODUCT CATALOG title', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('PRODUCT CATALOG'), findsOneWidget);
    });

    testWidgets('has custom header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CustomHeader), findsOneWidget);
    });

    testWidgets('has footer', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(FooterWidget), findsOneWidget);
    });

    testWidgets('is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays grid of products', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('displays 4 product cards', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ProductCard), findsNWidgets(4));
    });

    testWidgets('displays UOP Hoodie product', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('UOP Hoodie'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
    });

    testWidgets('displays UOP Cap product', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('UOP Cap'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
    });

    testWidgets('displays UOP T-shirt product', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('UOP T-shirt'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
    });

    testWidgets('displays UOP Beanie product', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('UOP Beanie'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
    });

    testWidgets('title has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final Text titleText = tester.widget(find.text('PRODUCT CATALOG'));
      expect(titleText.style?.fontSize, 20);
      expect(titleText.style?.color, Colors.black);
      expect(titleText.style?.letterSpacing, 1);
    });

    testWidgets('has white background', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final Container container = tester.widget(
        find.descendant(
          of: find.byType(SingleChildScrollView),
          matching: find.byType(Container),
        ),
      );

      expect(container.color, Colors.white);
    });

    testWidgets('has correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final Padding padding = tester.widget(
        find.descendant(
          of: find.byType(Container),
          matching: find.byType(Padding),
        ),
      );

      expect(padding.padding, const EdgeInsets.all(40.0));
    });

    testWidgets('GridView is not scrollable independently',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final GridView gridView = tester.widget(find.byType(GridView));
      expect(gridView.physics, isA<NeverScrollableScrollPhysics>());
      expect(gridView.shrinkWrap, true);
    });

    testWidgets('GridView has correct spacing', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final GridView gridView = tester.widget(find.byType(GridView));
      expect((gridView as dynamic).crossAxisSpacing, 24);
      expect((gridView as dynamic).mainAxisSpacing, 48);
    });

    testWidgets('screen is a StatelessWidget', (WidgetTester tester) async {
      const screen = ProductsPageScreen();
      expect(screen, isA<StatelessWidget>());
    });
  });

  group('ProductCard Tests', () {
    testWidgets('ProductCard displays title and price',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£99.99'), findsOneWidget);
    });

    testWidgets('ProductCard has GestureDetector', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('ProductCard displays image', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('ProductCard image has error builder',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'invalid_url',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });

    testWidgets('ProductCard title has correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      final Text titleText = tester.widget(find.text('Test Product'));
      expect(titleText.style?.fontSize, 14);
      expect(titleText.style?.color, Colors.black);
      expect(titleText.maxLines, 2);
    });

    testWidgets('ProductCard price has correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      final Text priceText = tester.widget(find.text('£99.99'));
      expect(priceText.style?.fontSize, 13);
      expect(priceText.style?.color, Colors.grey);
    });

    testWidgets('ProductCard navigates on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: MaterialApp(
            home: Scaffold(
              body: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // After navigation, we should see product page elements
      expect(find.text('Add to cart'), findsOneWidget);
    });

    testWidgets('ProductCard has column layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('ProductCard image is Expanded', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('ProductCard has spacing between elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsAtLeastNWidgets(2));
    });

    testWidgets('ProductCard columns are cross-axis start aligned',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      final columns = tester.widgetList<Column>(find.byType(Column));
      for (final column in columns) {
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
      }
    });

    testWidgets('ProductCard image has BoxFit.cover',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: 'Test Product',
                price: '£99.99',
                imageUrl: 'https://example.com/test.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.fit, BoxFit.cover);
    });

    testWidgets('ProductCard is a StatelessWidget',
        (WidgetTester tester) async {
      const card = ProductCard(
        title: 'Test',
        price: '£10',
        imageUrl: 'url',
        description: 'desc',
      );
      expect(card, isA<StatelessWidget>());
    });

    testWidgets('ProductCard has const constructor',
        (WidgetTester tester) async {
      const card = ProductCard(
        title: 'Test',
        price: '£10',
        imageUrl: 'url',
        description: 'desc',
      );
      expect(card, isA<ProductCard>());
    });

    testWidgets('ProductCard passes all properties correctly',
        (WidgetTester tester) async {
      const testTitle = 'Custom Title';
      const testPrice = '£50.00';
      const testUrl = 'https://example.com/custom.jpg';
      const testDesc = 'Custom description';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: const ProductCard(
                title: testTitle,
                price: testPrice,
                imageUrl: testUrl,
                description: testDesc,
              ),
            ),
          ),
        ),
      );

      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testPrice), findsOneWidget);
    });
  });
}
