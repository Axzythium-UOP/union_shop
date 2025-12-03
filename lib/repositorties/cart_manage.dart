// lib/repositorties/cart_manage.dart

// Minimal Product model provided here so the type exists.
// If you have a Product class elsewhere, remove this and import that file instead.
class Product {
  final double price;
  final int quantity;

  Product({required this.price, required this.quantity});
}

class PricingRepository {
  const PricingRepository();

  double calculatePriceForProduct(Product product) {
    return product.price * product.quantity; // assumes product has `price` and `quantity`
  }

  double calculateTotal(List<Product> products) {
    return products.fold(0.0, (sum, p) => sum + calculatePriceForProduct(p));
  }
}
