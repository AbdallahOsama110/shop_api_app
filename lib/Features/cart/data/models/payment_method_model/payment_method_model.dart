class PaymentMethodModel {
  final int id;
  final String methodName;
  final String methodImage;
  final String paymentMethod;

  PaymentMethodModel( {
    required this.id,
    required this.methodName,
    required this.methodImage,
    required this.paymentMethod,
  });
}
