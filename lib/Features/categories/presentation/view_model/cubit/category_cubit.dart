import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/urls.dart';
import '../../../data/models/category product/category_product_model.dart';
import '../../../../../core/api/api_service.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoryProductModel? categoryProductModel;

  void getCategoryProducts(int categoryId) {
    emit(GetCategoryProductLoadingState());
    ApiService.getData(
      url: Urls.products,
      query: {
        'category_id': categoryId,
      },
      lang: 'en',
    ).then((value) {
      categoryProductModel = CategoryProductModel.fromJson(value);
      print(
          '${categoryProductModel?.status} <============= category product status');
      emit(GetCategoryProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryProductErrorState());
    });
  }


/*     ChangeFavoriteModel? changeFavoriteModel;
  Map<int, bool> favorites = {};

  void changeFav(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavState());
    final token = CacheHelper.getData(key: 'token');
    ApiService.postData(
      endPoint: EndPoints.favorites,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (changeFavoriteModel?.status == false) {
        favorites[productId] = !favorites[productId]!;
        toastMessage(
            msg: changeFavoriteModel?.message ?? 'something wrong!',
            type: ToastType.error);
      } else {
        getFavorites();
      }
      //!print(value.data.toString());
      emit(ChangeFavSuccessState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      toastMessage(
          msg: changeFavoriteModel?.message ?? 'something wrong!',
          type: ToastType.error);
      print(error.toString());
      emit(ChangeFavErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorites() {
    emit(GetFavoriteLoadingState());
    final token = CacheHelper.getData(key: 'token');
    ApiService.getData(
      endPoint: EndPoints.favorites,
      token: token,
      lang: 'en',
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value);
      //print(value);
      //!print(favoriteModel?.status.toString());
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteErrorState());
    });
  } */

}
