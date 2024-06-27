class Product {
	int? id;
	int? quantity;
	double? price;
	String? name;
	String? image;

	Product({this.id, this.quantity, this.price, this.name, this.image});

	factory Product.fromJson(Map<String, dynamic> json) => Product(
				id: json['id'] as int?,
				quantity: json['quantity'] as int?,
				price: (json['price'] as num?)?.toDouble(),
				name: json['name'] as String?,
				image: json['image'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'quantity': quantity,
				'price': price,
				'name': name,
				'image': image,
			};
}
