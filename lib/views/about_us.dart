import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomHeader(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Us',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Welcome to Union Shop',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Union Shop is dedicated to providing quality products and exceptional customer service. Our mission is to support local communities and ensure fair trade practices.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Our Values',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            '• Quality: We offer only the finest products\n'
            '• Integrity: We conduct business ethically\n'
            '• Community: We support local businesses\n'
            '• Sustainability: We care for the environment',
          ),
        ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
