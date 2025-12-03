class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final String size;
  final String color;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.price,
    this.quantity = 1,
  });
}
