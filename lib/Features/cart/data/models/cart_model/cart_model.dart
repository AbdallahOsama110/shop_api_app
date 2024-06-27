import 'cart_data.dart';

class CartModel {
  final bool? status;
  final CartData? data;

  const CartModel({this.status, this.data});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: json['status'] as bool?,
        data: json['data'] == null
            ? null
            : CartData.fromJson(json['data'] as Map<String, dynamic>),
      );
}
