import 'address.dart';
import 'product.dart';

class Data {
	int? id;
	double? cost;
	int? discount;
	double? points;
	double? vat;
	double? total;
	int? pointsCommission;
	String? promoCode;
	String? paymentMethod;
	String? date;
	String? status;
	Address? address;
	List<Product>? products;

	Data({
		this.id, 
		this.cost, 
		this.discount, 
		this.points, 
		this.vat, 
		this.total, 
		this.pointsCommission, 
		this.promoCode, 
		this.paymentMethod, 
		this.date, 
		this.status, 
		this.address, 
		this.products, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				cost: (json['cost'] as num?)?.toDouble(),
				discount: json['discount'] as int?,
				points: (json['points'] as num?)?.toDouble(),
				vat: (json['vat'] as num?)?.toDouble(),
				total: (json['total'] as num?)?.toDouble(),
				pointsCommission: json['points_commission'] as int?,
				promoCode: json['promo_code'] as String?,
				paymentMethod: json['payment_method'] as String?,
				date: json['date'] as String?,
				status: json['status'] as String?,
				address: json['address'] == null
						? null
						: Address.fromJson(json['address'] as Map<String, dynamic>),
				products: (json['products'] as List<dynamic>?)
						?.map((e) => Product.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'cost': cost,
				'discount': discount,
				'points': points,
				'vat': vat,
				'total': total,
				'points_commission': pointsCommission,
				'promo_code': promoCode,
				'payment_method': paymentMethod,
				'date': date,
				'status': status,
				'address': address?.toJson(),
				'products': products?.map((e) => e.toJson()).toList(),
			};
}
