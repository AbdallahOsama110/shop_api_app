class CreateOrderInputModel{
  final String addressID;
  final String paymentMethod;
  final String usePoints;

  CreateOrderInputModel({
    required this.addressID,
    required this.paymentMethod,
    this.usePoints = 'false',
  });

  Map<String, dynamic> toJson() {
    return {
      'address_id': addressID,
      'payment_method': paymentMethod,
      'use_points': usePoints,
    };
  }
}