import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';


class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Using 'assets/images/Sales.png' from the assets/images folder
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/products_page');
                  },
                  child: SizedBox(
                    height: 200, // give the image a constrained height so it displays reliably
                    child: Image.asset(
                      'assets/images/Sales.png',
                      fit: BoxFit.contain,
                      // graceful fallback if the asset is missing
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
