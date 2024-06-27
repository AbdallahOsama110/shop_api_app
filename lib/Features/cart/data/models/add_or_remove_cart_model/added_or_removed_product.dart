class AddedOrRemovedProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  AddedOrRemovedProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  factory AddedOrRemovedProduct.fromJson(Map<String, dynamic> json) =>
      AddedOrRemovedProduct(
        id: json['id'] as int?,
        price: (json['price'] as num?)?.toDouble(),
        oldPrice: (json['old_price'] as num?)?.toDouble(),
        discount: json['discount'] as int?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'old_price': oldPrice,
        'discount': discount,
        'image': image,
        'name': name,
        'description': description,
      };
}
