import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(
        json['product'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
      quantity: json['quantity']?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product.toMap(),
        'quantity': quantity,
      };

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}
