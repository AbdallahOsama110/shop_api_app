import 'package:flutter/material.dart';
import '../../../../../core/widgets/price_widget.dart';
import '../../view model/cart cubit/cart_cubit.dart';

class CostWidget extends StatelessWidget {
  const CostWidget({
    super.key,
    required this.cartCubit,
  });

  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            PriceWidget(
              price: cartCubit.cartCostModel.deliveryCost == 0
                  ? 'Free'
                  : cartCubit.cartCostModel.deliveryCost,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            PriceWidget(price: cartCubit.cartCostModel.subTotalCost),
          ],
        ),
      ],
    );
  }
}
