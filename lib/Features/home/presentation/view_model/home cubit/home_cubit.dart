import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/home/data/models/product%20details%20model/product_details_model.dart';
import 'package:shop_api_app/core/functions/toast_message.dart';
import 'package:shop_api_app/core/utils/consts.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../categories/data/models/category_model/category_model.dart';
import '../../../../favorites/data/models/change_favorites_model.dart';
import '../../../../favorites/data/models/favorite_model/favorite_model.dart';
import '../../../data/models/home_data_model/home_data_model.dart';
import '../../../data/repos/home_repo.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;
  HomeDataModel? homeDataModelCubit;
  Future<void> getHomeData() async {
    emit(GetHomeDataLoadingState());
    var data = await homeRepo.getHomeData();
    data.fold(
      (failure) {
        emit(GetHomeDataErrorState(failure.errMessage));
      },
      (homeDataModel) {
        homeDataModelCubit = homeDataModel;
        homeDataModel.data?.products.forEach((elemet) {
          favorites.addAll({
            elemet.id!: elemet.inFavorites,
          });
        });
        emit(GetHomeDataSuccessState(homeDataModel));
      },
    );
  }

  Future<void> getHomeDataForCart() async {
    var data = await homeRepo.getHomeData();
    data.fold(
      (failure) {
        emit(GetHomeDataErrorState(failure.errMessage));
      },
      (homeDataModel) {
        homeDataModelCubit = homeDataModel;
        homeDataModel.data?.products.forEach((elemet) {
          favorites.addAll({
            elemet.id!: elemet.inFavorites,
          });
        });
        emit(GetHomeDataSuccessState(homeDataModel));
      },
    );
  }


  CategoryModel? categoryModel;

  void getCategories() {
    emit(GetCategoryLoadingState());
    ApiService.getData(url: Urls.categories, lang: 'en')
        .then((value) {
      categoryModel = CategoryModel.fromJson(value);
      emit(GetCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  Map<int, bool> favorites = {};

  void changeFav(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavState());
    final token = CacheHelper.getData(key: 'token');
    ApiService.postData(
      url: Urls.favorites,
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
      url: Urls.favorites,
      token: token,
      lang: 'en',
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteErrorState());
    });
  }

  ProductDetailsModel? productDetailsModel;
  Future<void> getProductDetailsById({required int productId}) async {
    try {
      emit(GetProductDetailsLoadingState());
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.getData(
        token: token,
        url: '${Urls.products}/$productId',
      );
      print('product value status ====> ${value['status']}');
      productDetailsModel = ProductDetailsModel.fromJson(value);
      print('productDetailsModel status ====> ${productDetailsModel?.status}');
      emit(GetProductDetailsSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetProductDetailsErrorState());
    }
  }

}
