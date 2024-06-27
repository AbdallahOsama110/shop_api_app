import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/functions/toast_message.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/consts.dart';
import '../../../data/models/get_order_details_model/get_order_details_model.dart';
import '../../../data/models/get_orders_model/get_orders_model.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  static OrdersCubit get(context) => BlocProvider.of(context);

  GetOrdersModel? getOrdersModel;
  Future<void> getOrders() async {
    try {
      emit(GetOrdersLoading());
      final token = CacheHelper.getData(key: 'token');
      log(token.toString());
      var value = await ApiService.getData(url: Urls.orders, token: token);
      getOrdersModel = GetOrdersModel.fromJson(value);
      emit(GetOrdersSuccess());
    } catch (e) {
      log(e.toString());
      toastMessage(msg: e.toString(), type: ToastType.error);
      emit(GetOrdersError());
    }
  }

  GetOrderDetailsModel? getOrderDetailsModel;
  Future<void> getOrderDetails({required int id}) async {
    try {
      emit(GetOrderDetailsLoading());
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.getData(
        url: '${Urls.orders}/$id',
        token: token,
      );
      getOrderDetailsModel = GetOrderDetailsModel.fromJson(value);
      emit(GetOrderDetailsSuccess());
    } catch (e) {
      log(e.toString());
      toastMessage(msg: e.toString(), type: ToastType.error);
      emit(GetOrderDetailsError());
    }
  }
}
