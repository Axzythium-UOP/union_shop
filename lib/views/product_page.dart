import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String description;

  const ProductPage({
    super.key,
    this.title = 'UOP Cap',
    this.price = '£9.00',
    this.imageUrl =
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    this.description =
        'This UOP Cap is a stylish and comfortable accessory perfect for showing off your University of Portsmouth pride. Made from high-quality materials, it features the UOP logo embroidered on the front. Whether you\'re on campus or out and about, this cap is a great way to complete your look.',
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedSize = 'S';
  String selectedColor = 'Purple';
  int selectedQuantity = 1;

  void placeholderCallback() {
    // placeholder - buttons do not have to function
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add to cart (placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // product image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Product title and price (added back)
              Text(
                widget.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                widget.price,
                style: const TextStyle(fontSize: 18, color: Color(0xFF4d2963), fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 18),

              // Options: size, color, quantity
              Row(
                children: [
                  // Size
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Size', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        DropdownButton<String>(
                          value: selectedSize,
                          isExpanded: true,
                          onChanged: (val) {
                            if (val != null) setState(() => selectedSize = val);
                          },
                          items: ['S', 'M', 'L', 'XL']
                              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Color
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Color', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        DropdownButton<String>(
                          value: selectedColor,
                          isExpanded: true,
                          onChanged: (val) {
                            if (val != null) setState(() => selectedColor = val);
                          },
                          items: ['Purple', 'Navy', 'White']
                              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Quantity
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Qty', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        DropdownButton<int>(
                          value: selectedQuantity,
                          isExpanded: true,
                          onChanged: (val) {
                            if (val != null) setState(() => selectedQuantity = val);
                          },
                          items: List.generate(10, (i) => i + 1)
                              .map((n) => DropdownMenuItem(value: n, child: Text(n.toString())))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Add to cart
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: placeholderCallback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d2963),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Add to cart'),
                ),
              ),

              const SizedBox(height: 20),

              // Product description
              const Text('Product Description',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
