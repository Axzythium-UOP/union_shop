import 'package:flutter/material.dart';
import 'package:union_shop/widgets/widgets.dart';

class AuthenticatioScreen extends StatelessWidget {
  const AuthenticatioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';

    return Scaffold(
      appBar: const CustomHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                username = value; // Store username input
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                password = value; // Store password input
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Show a SnackBar with the inputted username and password
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Username: $username, Password: $password'),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
