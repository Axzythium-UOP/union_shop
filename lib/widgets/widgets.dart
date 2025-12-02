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

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  /// A custom header widget matching the app's top header layout used in
  /// several screens. Implements [PreferredSizeWidget] so it can be used
  /// directly as an [AppBar] replacement.
  final double height;

  const CustomHeader({Key? key, this.height = 100}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _goAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about_us');
  }

  void _goCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

   void _goAuthentication(BuildContext context) {
    Navigator.pushNamed(context, '/authentication');
  }

  static void _noop() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.white,
      child: Column(
        children: [
          // Top purple banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'Free shipping on orders over £30!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Main header row
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _goHome(context),
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _goAbout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF4d2963),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            textStyle: const TextStyle(fontSize: 12),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Color(0xFF4d2963)),
                            ),
                          ),
                          child: const Text('ABOUT US'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => _goHome(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF4d2963),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            textStyle: const TextStyle(fontSize: 12),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Color(0xFF4d2963)),
                            ),
                          ),
                          child: const Text('HOME'),
                        ),
                        const SizedBox(width: 10),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.all(8),
                                constraints: BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: _noop,
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(
                                  Icons.person_outline,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () => _goAuthentication(context),
                              ),
                              const SizedBox(width: 8),
                              const IconButton(
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.all(8),
                                constraints: BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: _noop,
                              ),
                              const SizedBox(width: 8),
                              const IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.all(8),
                                constraints: BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: _noop,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
