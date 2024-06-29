import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import '../../../../../core/api/api_keys.dart';
import '../../../../../core/api/api_service.dart';
import '../../../../../core/api/urls.dart';
import '../../../../../core/functions/toast_message.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../../core/utils/stripe_service.dart';
import '../../../../orders/data/models/add_order_model/add_order_model.dart';
import '../../../../settings/data/models/get_address_model/get_address_model.dart';
import '../../../../settings/data/models/location_model/location_data.dart';
import '../../../data/models/Paypal_payment_method_model/paypal_amount_model/details.dart';
import '../../../data/models/Paypal_payment_method_model/paypal_amount_model/paypal_amount_model.dart';
import '../../../data/models/Paypal_payment_method_model/paypal_item_list_model/paypal_item_list_model.dart';
import '../../../data/models/create_order_input_model/create_order_input_model.dart';
import '../../../data/models/payment_intent_input_model/payment_intent_input_model.dart';
import '../../../data/models/payment_method_model/payment_method_model.dart';
import '../cart cubit/cart_cubit.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);

//!===================================( Start Payment )==============================================
  CreateOrderInputModel? createOrderInputModel;
  Future<void> startPayment(
    BuildContext context, {
    required CartCubit cartCubit,
  }) async {
    if (selectedAddress != null) {
      if (paymentMethodModel.id == 1) {
        await startCardPaymentWithStripe(cartCubit: cartCubit);
      } else if (paymentMethodModel.id == 2) {
        await startPaypalPayment(context, cartCubit: cartCubit);
      } else if (paymentMethodModel.id == 3) {
        emit(PaymentLoading());
        await addOrder();
        emit(PaymentSuccess());
      }
    } else {
      toastMessage(msg: 'go to settings to add address', type: ToastType.error);
      emit(PaymentError());
    }
  }
//!===================================( Card Payment Methods )=======================================
  Future<void> startCardPaymentWithStripe({
    required CartCubit cartCubit,
  }) async {
    try {
      emit(PaymentLoading());
      await StripeService.startPayment(
        paymentIntentInputModel: PaymentIntentInputModel(
          customerID: CacheHelper.getData(key: 'customerID'),
          amount: '${(cartCubit.cartCostModel.totalCost! * 100).toInt()}',
          currency: 'USD',
        ),
      );
      toastMessage(msg: 'Checkout successfully...', type: ToastType.success);
      emit(PaymentSuccess());
      await addOrder();
    } catch (e) {
      toastMessage(msg: 'incomplete checkout', type: ToastType.error);
      log(e.toString());
      emit(PaymentError());
    }
  }
  //!===================================( Payment Methods )==============================================
  PaymentMethodModel paymentMethodModel = paymentMethodsList[0];
  int activeMethodIndex = 0;
  void setActivePaymentMethod({required int index}) {
    activeMethodIndex = index;
    paymentMethodModel = paymentMethodsList[index];
    log('changing payment to: ${paymentMethodModel.methodName}');
    emit(PaymentMethodChanged());
  }
  //!===================================( Get Addresses )==============================================
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
//!===================================( Set Active Address )==============================================
  void setActivePaymentAddress(LocationData? address) {
    selectedAddress = address;
    log('changing Address to: ${selectedAddress?.name ?? 'null'}');
    emit(PaymentAddressChanged());
  }
  //!===================================( Add New Order )==============================================
  AddOrderModel? addOrderModel;
  Future<void> addOrder() async {
    try {
      emit(CreateOrderLoading());
      createOrderInputModel = CreateOrderInputModel(
        addressID: selectedAddress?.id.toString() ?? '1',
        paymentMethod: paymentMethodModel.paymentMethod,
      );
      final token = CacheHelper.getData(key: 'token');
      var value = await ApiService.postData(
        token: token,
        url: Urls.orders,
        data: createOrderInputModel?.toJson() ?? {},
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
//!===================================( Paypal Payment Methods )=======================================
  PaypalAmountModel? paypalAmountModel;
  PaypalItemListModel? paypalItemListModel;

  Future<void> startPaypalPayment(
    BuildContext context, {
    required CartCubit cartCubit,
  }) async {
    try {
      emit(PaymentLoading());
      paypalAmountModel = PaypalAmountModel(
        currency: 'USD',
        total: cartCubit.cartCostModel.totalCost.toString(),
        details: Details(
          subtotal: cartCubit.cartCostModel.subTotalCost.toString(),
          shipping: cartCubit.cartCostModel.deliveryCost.toString(),
          shippingDiscount: cartCubit.cartCostModel.discountCost,
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PaypalCheckoutView(
            sandboxMode: true,
            clientId: ApiKeys.clientId,
            secretKey: ApiKeys.paypalSecretKey,
            transactions: [
              {
                "amount": paypalAmountModel?.toJson() ?? {},
                "description": "The payment transaction description.",
                "item_list": {
                  "items": cartCubit.paypalItemListModel?.items!
                          .map((e) => e.toJson())
                          .toList() ??
                      [],
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              log("onSuccess: $params");
              await addOrder();
              if (context.mounted) Navigator.pop(context);
              emit(PaymentSuccess());
            },
            onError: (error) {
              toastMessage(msg: "Error: $error", type: ToastType.error);
              log("onError: $error");
              Navigator.pop(context);
              emit(PaymentError());
            },
            onCancel: () {
              toastMessage(msg: "cancelled", type: ToastType.error);
              log('cancelled:');
              Navigator.pop(context);
              emit(PaymentError());
            },
          ),
        ),
      );
    } catch (e) {
      emit(PaymentError());
    }
  }
}
