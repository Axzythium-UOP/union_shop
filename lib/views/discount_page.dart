import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';

class DiscountPageScreen extends StatelessWidget {
  const DiscountPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomHeader(),
      body: Center(
        child: Text('This is for the discounted product page.'),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
