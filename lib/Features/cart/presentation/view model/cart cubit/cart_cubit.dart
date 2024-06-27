import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/cart/data/models/add_or_remove_cart_model/add_or_remove_cart_model.dart';
import 'package:shop_api_app/Features/cart/data/models/cart_model/cart_model.dart';
import 'package:shop_api_app/core/api/urls.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/functions/toast_message.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../search/data/models/search_model/search_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  String deliveryCost = 'Free';
  dynamic totalCost;

  CartModel? cartModel;
  Future<void> getCartItem() async {
    try {
      emit(GetCartLoadingState());
      final token = await CacheHelper.getData(key: 'token');
      var value = await ApiService.getData(
        url: Urls.cart,
        query: null,
        token: token,
        lang: 'en',
      );
      log('Cart value status ==> ${value['status']}');
      cartModel = CartModel.fromJson(value);
      totalCost = cartModel?.data?.total ?? 0.0;
      if (cartModel?.data?.total < 500) {
        deliveryCost = '150';
        totalCost += 150;
      } else {
        deliveryCost = 'Free';
      }
      await searchProduct();

      cartModel?.data?.cartItems?.forEach((elemet) {
        cart.addAll({
          elemet.product?.id ?? 52: elemet.product?.inCart ?? true,
        });
      });
      log('cartModel status ==> ${cartModel?.status}');
      emit(GetCartSuccessState());
    } catch (e) {
      if (e is DioException) {
        emit(GetCartErrorState());
      }
      log(e.toString());
      emit(GetCartErrorState());
    }
  }

  AddOrRemoveCartModel? addOrRemoveCartModel;
  Map<int, bool> cart = {};
  Future<void> addAndRemoveCartItem({required int productId}) async {
    try {
      cart[productId] = !cart[productId]!;
      emit(AddOrRemoveCartItemLoadingState());
      final token = await CacheHelper.getData(key: 'token');
      var value = await ApiService.postData(
        token: token,
        url: Urls.cart,
        data: {
          'product_id': productId,
        },
      );
      log('Cart value status ==> ${value.data['status']}');
      addOrRemoveCartModel = AddOrRemoveCartModel.fromJson(value.data);
      if (addOrRemoveCartModel?.status == false) {
        cart[productId] = !cart[productId]!;
        toastMessage(
            msg: addOrRemoveCartModel?.message ?? 'something wrong!',
            type: ToastType.error);
      } else {
        await getCartItem();
      }
      print('cartModel status ==> ${addOrRemoveCartModel?.status}');
      emit(AddOrRemoveCartItemSuccessState());
    } catch (e) {
      cart[productId] = !cart[productId]!;
      toastMessage(msg: e.toString(), type: ToastType.error);
      if (e is DioException) {
        emit(AddOrRemoveCartItemErrorState());
      }
      log(e.toString());
      emit(AddOrRemoveCartItemErrorState());
    }
  }

  SearchModel? searchModel;
  Future<void> searchProduct() async {
    try {
      final token = await CacheHelper.getData(key: 'token');
      var value = await ApiService.postData(
        token: token,
        url: Urls.search,
        data: {
          'text': '',
        },
      );
      searchModel = SearchModel.fromJson(value.data);
      searchModel?.data?.data?.forEach((elemet) {
        cart.addAll({
          elemet.id!: elemet.inCart!,
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateCart({
    required int id,
    required int quantity,
  }) async {
    try {
      emit(UpdateCartItemLoadingState());
      final token = await CacheHelper.getData(key: 'token');
      var value = await ApiService.putData(
        url: '${Urls.cart}/$id',
        data: {
          'quantity': quantity,
        },
        token: token,
      );
      print(value.data['message']);
      emit(UpdateCartItemSuccessState());
      //! getCartItem();
      try {
        final token = await CacheHelper.getData(key: 'token');
        print('token ==> $token');
        var value = await ApiService.getData(
          url: Urls.cart,
          query: null,
          token: token,
          lang: 'en',
        );
        print('Cart value status ==> ${value['status']}');
        cartModel = CartModel.fromJson(value);
        totalCost = cartModel?.data?.total ?? 0.0;
        if (cartModel?.data?.total < 500) {
          deliveryCost = '150';
          totalCost += 150;
        } else {
          deliveryCost = 'Free';
        }
        print('cartModel status ==> ${cartModel?.status}');
        emit(GetCartSuccessState());
      } catch (e) {
        if (e is DioException) {
          emit(GetCartErrorState());
        }
        print(e.toString());
        emit(GetCartErrorState());
      }
    } catch (e) {
      if (e is DioException) {
        emit(UpdateCartItemErrorState());
      }
      print(e.toString());
      emit(UpdateCartItemErrorState());
    }
  }
}
