import 'favorite_product_model.dart';

class FavData {
  int? id;
  FavoriteProductModel? product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    product = json['product'] == null
        ? null
        : FavoriteProductModel.fromJson(
            json['product'] as Map<String, dynamic>);
  }
}
