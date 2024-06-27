import 'package:dio/dio.dart';
import 'package:shop_api_app/Features/auth/data/models/create_customer_model/create_customer_model.dart';
import 'package:shop_api_app/Features/cart/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:shop_api_app/Features/cart/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:shop_api_app/core/api/api_keys.dart';
import 'package:shop_api_app/core/api/api_service.dart';
import 'package:shop_api_app/core/functions/toast_message.dart';
import 'package:shop_api_app/core/utils/consts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../Features/cart/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import '../api/urls.dart';
import 'cache_helper.dart';

class StripeService {
  static var customerID = CacheHelper.getData(key: 'customerID');

  static Future<PaymentIntentModel> createPaymentIntent(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var response = await ApiService.postData(
      url: Urls.paymentIntents,
      data: paymentIntentInputModel.toJson(),
      token: ApiKeys.secretKey,
      contentType: Headers.formUrlEncodedContentType,
      isPayment: true,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  static Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
    String? ephemeralKeySecret,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          merchantDisplayName: 'Shopee',
          paymentIntentClientSecret: paymentIntentClientSecret,
          customerEphemeralKeySecret: ephemeralKeySecret,
          customerId: customerID,
        ),
      );
    } catch (e) {
      toastMessage(msg: 'Error: $e', type: ToastType.error);
      rethrow;
    }
  }

  static Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  static Future<void> startPayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    var ephemeralKeyModel = customerID != null
        ? (await createEphemeralKey(customerID: customerID)).secret
        : null;
    await initPaymentSheet(
      paymentIntentClientSecret: paymentIntentModel.clientSecret!,
      ephemeralKeySecret: ephemeralKeyModel,
    );
    await displayPaymentSheet();
  }

  static Future<CreateCustomerModel> createCustomer(
      {required CreateCustomerModel createCustomerInput}) async {
    var response = await ApiService.postData(
      url: Urls.customers,
      data: createCustomerInput.toJson(),
      token: ApiKeys.secretKey,
      contentType: Headers.formUrlEncodedContentType,
      isPayment: true,
    );
    var createCustomerModel = CreateCustomerModel.fromJson(response.data);
    return createCustomerModel;
  }

  static Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerID}) async {
    var response = await ApiService.postData(
      url: Urls.createEphemeralkeys,
      data: {'customer': customerID},
      token: ApiKeys.secretKey,
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Authorization': 'Bearer ${ApiKeys.secretKey}',
        'Content-Type': Headers.formUrlEncodedContentType,
        'Stripe-Version': '2024-04-10',
      },
      isPayment: true,
    );
    var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyModel;
  }
}
