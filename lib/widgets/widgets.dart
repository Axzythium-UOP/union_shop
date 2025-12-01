import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: const Text(
        'Contact Email: Daniel.t.gardner@hotmail.com / Phone: 123-123-123 \n'
        '© 2025 Union Shop. All rights reserved. \n'
        'Privacy Policy | Terms of Service',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}