part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class GetOrdersLoading extends OrdersState {}
final class GetOrdersSuccess extends OrdersState {}
final class GetOrdersError extends OrdersState {}

final class GetOrderDetailsLoading extends OrdersState {}
final class GetOrderDetailsSuccess extends OrdersState {}
final class GetOrderDetailsError extends OrdersState {}
