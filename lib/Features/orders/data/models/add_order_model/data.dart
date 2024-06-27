class Data {
	String? paymentMethod;
	double? cost;
	double? vat;
	int? discount;
	double? points;
	double? total;
	int? id;

	Data({
		this.paymentMethod, 
		this.cost, 
		this.vat, 
		this.discount, 
		this.points, 
		this.total, 
		this.id, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				paymentMethod: json['payment_method'] as String?,
				cost: (json['cost'] as num?)?.toDouble(),
				vat: (json['vat'] as num?)?.toDouble(),
				discount: json['discount'] as int?,
				points: (json['points'] as num?)?.toDouble(),
				total: (json['total'] as num?)?.toDouble(),
				id: json['id'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'payment_method': paymentMethod,
				'cost': cost,
				'vat': vat,
				'discount': discount,
				'points': points,
				'total': total,
				'id': id,
			};
}
