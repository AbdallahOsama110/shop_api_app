import 'package:equatable/equatable.dart';
import 'cart_product.dart';

// ignore: must_be_immutable
class CartItem extends Equatable {
  final int? id;
  int? quantity;
  final CartProduct? product;

  CartItem({this.id, this.quantity, this.product});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'] as int?,
        quantity: json['quantity'] as int?,
        product: json['product'] == null
            ? null
            : CartProduct.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'product': product?.toJson(),
      };

  @override
  List<Object?> get props => [id, quantity, product];
}
