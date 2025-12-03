import 'package:flutter/material.dart';
import 'package:union_shop/views/authentication_page.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/products_page.dart';
import 'package:union_shop/views/about_us.dart';
import 'package:union_shop/widgets/widgets.dart';
import 'package:union_shop/views/collections.dart';


class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/products_page': (context) => const ProductsPageScreen(),
        '/about_us': (context) => const AboutUsScreen(),
        '/collections': (context) => const CollectionsScreen(),
        '/authentication': (context) => const AuthenticatioScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  void navigateToAboutUs(BuildContext context) {
    Navigator.pushNamed(context, '/about_us');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToAuthentication(BuildContext context) {
    Navigator.pushNamed(context, '/authentication');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Sales',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/collections');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE PRODUCTS',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'PRODUCTS SECTION',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      children: [
                        ProductCard(
                          title: 'UOP Magnet',
                          price: '£10.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                          description:
                              'A decorative magnet featuring the UOP design — perfect for fridges and lockers.',
                        ),
                        ProductCard(
                          title: 'UOP Cap',
                          price: '£15.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/products/Cap-Purple_1024x1024@2x.jpg?v=1742201981',
                          description:
                              'A stylish cap with an embroidered UOP logo — adjustable and comfortable for everyday wear.',
                        ),
                        ProductCard(
                          title: 'UOP T-shirt',
                          price: '£20.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/Sage_T-shirt_1024x1024@2x.png?v=1759827236',
                          description:
                              'Soft cotton T-shirt with UOP branding — comfortable and suitable for everyday use.',
                        ),
                        ProductCard(
                          title: 'UOP Tote Bag',
                          price: '£25.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/products/cottonshopper_1024x1024@2x.jpg?v=1657540427',
                          description:
                              'Durable cotton tote bag with UOP print — great for carrying books and daily essentials.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

// Using `ProductCard` from `products_page.dart` which includes `description` and
// navigates to `ProductDetailsPage`.
