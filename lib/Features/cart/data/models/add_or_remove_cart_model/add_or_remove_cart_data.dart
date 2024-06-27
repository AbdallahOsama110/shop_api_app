import 'added_or_removed_product.dart';

class AddOrRemoveCartData {
  int? id;
  int? quantity;
  AddedOrRemovedProduct? product;

  AddOrRemoveCartData({this.id, this.quantity, this.product});

  factory AddOrRemoveCartData.fromJson(Map<String, dynamic> json) =>
      AddOrRemoveCartData(
        id: json['id'] as int?,
        quantity: json['quantity'] as int?,
        product: json['product'] == null
            ? null
            : AddedOrRemovedProduct.fromJson(
                json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'product': product?.toJson(),
      };
}
