import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';
import 'product_page.dart';

class ProductsPageScreen extends StatelessWidget {
  const ProductsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'PRODUCT CATALOG',
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
                      children: const [
                        ProductCard(
                          title: 'UOP Hoodie',
                          price: '£10.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal.jpg?v=1742201957',
                          description:
                              'A comfortable hoodie featuring the UOP design — perfect for staying warm and stylish.',
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
                              'https://shop.upsu.net/cdn/shop/products/PurpleTshirtFinal_1024x1024@2x.png?v=1669713197',
                          description:
                              'Soft cotton T-shirt with UOP branding — comfortable and suitable for everyday use.',
                        ),
                        ProductCard(
                          title: 'UOP Beanie',
                          price: '£25.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/products/Beanie-Purple_1024x1024@2x.jpg?v=1742201998',
                          description:
                              'A warm beanie featuring the UOP logo — perfect for colder days and outdoor activities.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              title: title,
              price: price,
              imageUrl: imageUrl,
              description: description,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
