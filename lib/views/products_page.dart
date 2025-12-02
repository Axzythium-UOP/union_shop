import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';

class ProductsPageScreen extends StatelessWidget {
  const ProductsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomHeader(),
      body: Center(
        child: Text('This is for the products page.'),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
