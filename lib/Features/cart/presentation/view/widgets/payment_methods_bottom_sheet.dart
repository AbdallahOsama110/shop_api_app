import 'dart:developer';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_api_app/Features/cart/presentation/view%20model/cart%20cubit/cart_cubit.dart';
import 'package:shop_api_app/Features/cart/presentation/view%20model/payment%20cubit/payment_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_button.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../data/models/create_order_input_model/create_order_input_model.dart';
import '../../../data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'select_address_dropdown.dart';
import 'select_payment_listview.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (BuildContext context, PaymentState state) {
        if (state is PaymentError) Navigator.pop(context);
        if (state is CreateOrderSuccess) {
          Navigator.pop(context);
          GoRouter.of(context).push('/thanks');
          CartCubit.get(context).getCartItem();
        }
      },
      builder: (context, state) {
        var paymentCubit = PaymentCubit.get(context);
        var size = MediaQuery.sizeOf(context);
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SelectPaymentMethodListView(paymentCubit: paymentCubit),
                  SizedBox(height: size.width * .1),
                  ConditionalBuilder(
                    condition: state is! GetAddressPaymentLoading,
                    builder: (context) => SelectPaymentAddressDropdown(
                      paymentCubit: paymentCubit,
                    ),
                    fallback: (BuildContext context) =>
                        const CustomLoadingIndicator(),
                  ),
                  SizedBox(height: size.width * .1),
                  CustomButton(
                    text: 'Continue',
                    isLoading: state is PaymentLoadingStates,
                    width: size.width,
                    overlayColor: Colors.greenAccent,
                    onPressed: () {
                      log('test customer id = ${CacheHelper.getData(key: 'customerID')}');
                      paymentCubit.startPayment(
                        createOrderInputModel: CreateOrderInputModel(
                          addressID:
                              paymentCubit.selectedAddress?.id.toString() ??
                                  '1',
                          paymentMethod:
                              paymentCubit.paymentMethodModel.paymentMethod,
                        ),
                        paymentIntentInputModel: PaymentIntentInputModel(
                          customerID: CacheHelper.getData(key: 'customerID'),
                          amount:
                              '${(CartCubit.get(context).totalCost * 100).toInt()}',
                          currency: 'USD',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: size.width * .1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
