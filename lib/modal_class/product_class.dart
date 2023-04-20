



class Product {
 final int id;
  final String name;
  final String category;
  final int price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
  });

  factory Product.fromMap({required Map<String, dynamic> data}) {
    return Product(
      id: data['id'],
      name: data['name'],
      category: data['category'],
      price: data['price'],
      quantity: data['quantity'],
    );
  }
}
