

class ProductData {
  final String name;
  final String category;
  final int price;
  final int quantity;

  ProductData({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
  });

  factory ProductData.fromMap({required ProductData data}) {
    return ProductData(
      name: data.name,
     category: data.category,
      price: data.price,
      quantity: data.quantity,
    );
  }
}