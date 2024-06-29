import 'dart:developer';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';
import '../../view model/cart cubit/cart_cubit.dart';
import '../../view model/payment cubit/payment_cubit.dart';
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
                        context,
                        cartCubit: CartCubit.get(context),
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
