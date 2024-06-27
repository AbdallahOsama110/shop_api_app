part of 'cart_cubit.dart';

sealed class CartStates extends Equatable {
  const CartStates();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartStates {}

final class GetCartLoadingState extends CartStates {}

final class GetCartSuccessState extends CartStates {}

final class GetCartErrorState extends CartStates {} 

final class AddOrRemoveCartItemLoadingState extends CartStates {}

final class AddOrRemoveCartItemSuccessState extends CartStates {}

final class AddOrRemoveCartItemErrorState extends CartStates {}

final class UpdateCartItemLoadingState extends CartStates {}

final class UpdateCartItemSuccessState extends CartStates {}

final class UpdateCartItemErrorState extends CartStates {}
