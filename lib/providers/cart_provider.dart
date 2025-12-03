import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addItem({
    required String title,
    required String imageUrl,
    required String size,
    required String color,
    required double price,
    int quantity = 1,
  }) {
    // Try to combine items with same title+size+color
    final existingKey = _items.keys.firstWhere(
      (k) {
        final it = _items[k]!;
        return it.title == title && it.size == size && it.color == color;
      },
      orElse: () => '',
    );

    if (existingKey.isNotEmpty) {
      _items[existingKey]!.quantity += quantity;
    } else {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      _items[id] = CartItem(
        id: id,
        title: title,
        imageUrl: imageUrl,
        size: size,
        color: color,
        price: price,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  
