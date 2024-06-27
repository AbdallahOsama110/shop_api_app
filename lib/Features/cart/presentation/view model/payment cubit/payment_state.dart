part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoadingStates extends PaymentState {}

final class PaymentLoading extends PaymentLoadingStates {}

final class PaymentSuccess extends PaymentState {}

final class PaymentError extends PaymentState {}

final class PaymentMethodChanged extends PaymentState {}

final class PaymentAddressChanged extends PaymentState {}

final class GetAddressPaymentLoading extends PaymentLoadingStates {}

final class GetAddressPaymentSuccess extends PaymentState {}

final class GetAddressPaymentError extends PaymentState {}

final class CreateOrderLoading extends PaymentLoadingStates {}

final class CreateOrderSuccess extends PaymentState {}

final class CreateOrderError extends PaymentState {}
