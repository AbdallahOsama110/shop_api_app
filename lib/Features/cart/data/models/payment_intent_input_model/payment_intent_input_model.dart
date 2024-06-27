class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String? customerID;

  PaymentIntentInputModel(
      {this.customerID, required this.amount, required this.currency});

  toJson() {
    return customerID != null || customerID != ''
        ? {
            'amount': amount,
            'currency': currency,
            'customer': customerID,
          }
        : {
            'amount': amount,
            'currency': currency,
          };
  }
}
