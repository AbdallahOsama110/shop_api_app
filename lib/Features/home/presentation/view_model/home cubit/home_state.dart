part of 'home_cubit.dart';

abstract class HomeStates {}

final class HomeInitial extends HomeStates {}

final class GetHomeDataLoadingState extends HomeStates {}

final class GetHomeDataSuccessState extends HomeStates {
  final HomeDataModel homeDataModel;

  GetHomeDataSuccessState(this.homeDataModel);
}

final class GetHomeDataErrorState extends HomeStates {
  final String errMessage;

  GetHomeDataErrorState(this.errMessage);
}

final class GetCategoryLoadingState extends HomeStates {}

final class GetCategorySuccessState extends HomeStates {}

final class GetCategoryErrorState extends HomeStates {}

final class ChangeFavSuccessState extends HomeStates {}

final class ChangeFavErrorState extends HomeStates {}

final class ChangeFavState extends HomeStates {}

final class GetFavoriteLoadingState extends HomeStates {}

final class GetFavoriteSuccessState extends HomeStates {}

final class GetFavoriteErrorState extends HomeStates {}

final class GetProductDetailsLoadingState extends HomeStates {}

final class GetProductDetailsSuccessState extends HomeStates {}

final class GetProductDetailsErrorState extends HomeStates {}
