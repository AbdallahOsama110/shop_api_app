class FavoriteProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'] as String?;
    name = json['name'] as String?;
    description = json['description'] as String?;
  }
}
