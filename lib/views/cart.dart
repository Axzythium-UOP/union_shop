import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Your Cart',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              // Content
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text('Your cart is empty',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.grey[600])),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final it = items[i];
                          return Card(
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      it.imageUrl,
                                      width: 72,
                                      height: 72,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                          width: 72,
                                          height: 72,
                                          color: Colors.grey[300]),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(it.title,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        const SizedBox(height: 6),
                                        Text('Size: ${it.size} • ${it.color}',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color: Colors.grey[600])),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Quantity controls
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 32,
                                                  width: 32,
                                                  child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      side: BorderSide(
                                                          color: Colors
                                                              .grey.shade300),
                                                    ),
                                                    onPressed: () =>
                                                        cart.decreaseQuantity(
                                                            it.id),
                                                    child: const Icon(
                                                        Icons.remove,
                                                        size: 18),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text('${it.quantity}',
                                                    style: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                  height: 32,
                                                  width: 32,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF4d2963),
                                                    ),
                                                    onPressed: () =>
                                                        cart.increaseQuantity(
                                                            it.id),
                                                    child: const Icon(Icons.add,
                                                        size: 18),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Text(
                                                '£${(it.price * it.quantity).toStringAsFixed(2)}',
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: const Color(
                                                            0xFF4d2963),
                                                        fontWeight:
                                                            FontWeight.w700)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => cart.removeItem(it.id),
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Divider
              const SizedBox(height: 12),
              Container(height: 1, color: Colors.grey[200]),
              const SizedBox(height: 12),

              // Total and actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text('£${cart.totalPrice.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4d2963))),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 220,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/products_page');
                            },
                            child: const Text('Continue Shopping'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 220,
                          child: OutlinedButton(
                            onPressed: () {
                              cart.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Order placed! Cart cleared.')));
                            },
                            child: const Text('Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
