class CartModel {
  final List<CartItemModel> items;

  CartModel({required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class CartItemModel {
  final int productId;
  final int quantity;
  final double? spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'],
      quantity: json['quantity'],
      spicy: json['spicy'] != null ? (json['spicy'] as num).toDouble() : null,
      toppings: List<int>.from(json['toppings'] ?? []),
      sideOptions: List<int>.from(json['side_options'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      if (spicy != null) 'spicy': spicy,
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }
}
