import 'cart_item.dart';

class CartData {
  final List<CartItem>? cartItems;
  final dynamic subTotal;
  final dynamic total;

  const CartData({this.cartItems, this.subTotal, this.total});

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        cartItems: (json['cart_items'] as List<dynamic>?)
            ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        subTotal: json['sub_total'],
        total: json['total'],
      );
}
