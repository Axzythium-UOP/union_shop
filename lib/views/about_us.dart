import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomHeader(),
      body: Center(
        child: Text('This is for the About Us page.'),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
