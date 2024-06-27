import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/cart/data/models/create_order_input_model/create_order_input_model.dart';
import 'package:shop_api_app/Features/cart/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:shop_api_app/Features/cart/data/models/payment_method_model/payment_method_model.dart';
import 'package:shop_api_app/Features/orders/data/models/add_order_model/add_order_model.dart';
import 'package:shop_api_app/core/functions/toast_message.dart';
import 'package:shop_api_app/core/utils/consts.dart';
import 'package:shop_api_app/core/utils/stripe_service.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../settings/data/models/get_address_model/get_address_model.dart';
import '../../../../settings/data/models/location_model/location_data.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future<void> startPayment({
    required PaymentIntentInputModel paymentIntentInputModel,
    required CreateOrderInputModel createOrderInputModel,
  }) async {
    if (selectedAddress != null) {
      if (paymentMethodModel.id == 1) {
        await startCardPaymentWithStripe(
          paymentIntentInputModel: paymentIntentInputModel,
          createOrderInputModel: createOrderInputModel,
        );
      } else if (paymentMethodModel.id == 3) {
        emit(PaymentLoading());
        await addOrder(createOrderInputModel: createOrderInputModel);
        emit(PaymentSuccess());
      } else if (paymentMethodModel.id == 2) {
        toastMessage(msg: 'Paypal not supported yet', type: ToastType.error);
        emit(PaymentError());
      }
    } else {
      toastMessage(msg: 'go to settings to add address', type: ToastType.error);
      emit(PaymentError());
    }
  }

  Future<void> startCardPaymentWithStripe({
    required PaymentIntentInputModel paymentIntentInputModel,
    required CreateOrderInputModel createOrderInputModel,
  }) async {
    try {
      emit(PaymentLoading());
      await StripeService.startPayment(
          paymentIntentInputModel: paymentIntentInputModel);
      toastMessage(msg: 'Checkout successfully...', type: ToastType.success);
      emit(PaymentSuccess());
      await addOrder(createOrderInputModel: createOrderInputModel);
    } catch (e) {
      toastMessage(msg: 'incomplete checkout', type: ToastType.error);
      log(e.toString());
      emit(PaymentError());
    }
  }

  PaymentMethodModel paymentMethodModel = paymentMethodsList[0];
  int activeMethodIndex = 0;
  void setActivePaymentMethod({required int index}) {
    activeMethodIndex = index;
    paymentMethodModel = paymentMethodsList[index];
    log('changing payment to: ${paymentMethodModel.methodName}');
    emit(PaymentMethodChanged());
  }

  LocationData? selectedAddress;
  GetAddressModel? getAddressModel;
  Future<void> getAddressesPayment() async {
    try {
      emit(GetAddressPaymentLoading());
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.getData(url: Urls.addresses, token: token);
      getAddressModel = GetAddressModel.fromJson(value);
      selectedAddress = getAddressModel!.data!.data![0];
      emit(GetAddressPaymentSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetAddressPaymentError());
    }
  }

  void setActivePaymentAddress(LocationData? address) {
    selectedAddress = address;
    log('changing Address to: ${selectedAddress?.name ?? 'null'}');
    emit(PaymentAddressChanged());
  }

  //!===================================( Add New Order)=======================================
  AddOrderModel? addOrderModel;
  Future<void> addOrder(
      {required CreateOrderInputModel createOrderInputModel}) async {
    try {
      emit(CreateOrderLoading());
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.postData(
        token: token,
        url: Urls.orders,
        data: createOrderInputModel.toJson(),
      );
      addOrderModel = AddOrderModel.fromJson(value.data);
      if (addOrderModel?.status == true) {
        toastMessage(
            msg: addOrderModel?.message ?? 'Success', type: ToastType.success);
        emit(CreateOrderSuccess());
      } else {
        toastMessage(
            msg: addOrderModel?.message ?? 'something invalid',
            type: ToastType.error);
        emit(CreateOrderError());
      }
    } catch (e) {
      toastMessage(msg: e.toString(), type: ToastType.error);
      emit(CreateOrderError());
    }
  }
}
