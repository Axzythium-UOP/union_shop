import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomHeader(),
      body: Center(
        child: Text('This is for the collections page.'),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
