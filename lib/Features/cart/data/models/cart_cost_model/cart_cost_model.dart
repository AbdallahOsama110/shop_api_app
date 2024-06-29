class CartCostModel {
  dynamic totalCost;
  dynamic deliveryCost;
  final dynamic discountCost;
  final dynamic subTotalCost;

  CartCostModel({
    this.deliveryCost,
    required this.discountCost,
    required this.subTotalCost,
    this.totalCost,
  }) {
    if (subTotalCost < 500) {
      deliveryCost = 150;
    } else {
      deliveryCost = 0;
    }
    totalCost = subTotalCost + deliveryCost - discountCost;
  }

  factory CartCostModel.fromJson(Map<String, dynamic> json) {
    return CartCostModel(
      totalCost: json['totalCost'],
      deliveryCost: json['deliveryCost'],
      discountCost: json['discountCost'],
      subTotalCost: json['subTotalCost'],
    );
  }
}
