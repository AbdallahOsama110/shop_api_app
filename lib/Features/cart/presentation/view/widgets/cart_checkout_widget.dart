import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/price_widget.dart';
import '../../../../shop/presentation/view_models/shop cubit/shop_cubit.dart';
import '../../view model/cart cubit/cart_cubit.dart';
import '../../view model/payment cubit/payment_cubit.dart';
import 'checkout_divider_widget.dart';
import 'cost_widget.dart';
import 'payment_methods_bottom_sheet.dart';

class CartChechOutAndCostWidget extends StatelessWidget {
  const CartChechOutAndCostWidget({
    super.key,
    required this.cartCubit,
    required this.size,
  });

  final CartCubit cartCubit;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 20, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CostWidget(cartCubit: cartCubit),
          const SizedBox(height: 10),
          const CheckoutDividerWidget(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              PriceWidget(
                price: cartCubit.cartCostModel.totalCost,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Checkout',
            width: size.width,
            overlayColor: Colors.greenAccent,
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                elevation: 0,
                backgroundColor: ShopCubit.get(context).isDark
                    ? scaffoldBackgroundColorDark
                    : scaffoldBackgroundColorLight,
                builder: (context) {
                  return BlocProvider(
                    create: (BuildContext context) =>
                        PaymentCubit()..getAddressesPayment(),
                    child: const PaymentMethodsBottomSheet(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}