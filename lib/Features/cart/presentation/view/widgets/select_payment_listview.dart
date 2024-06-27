import 'package:flutter/material.dart';
import '../../../../../core/utils/consts.dart';
import '../../view model/payment cubit/payment_cubit.dart';
import 'payment_method_item.dart';

class SelectPaymentMethodListView extends StatelessWidget {
  const SelectPaymentMethodListView({
    super.key,
    required this.paymentCubit,
  });

  final PaymentCubit paymentCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select Payment Method',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: MediaQuery.sizeOf(context).width * .05),
        SizedBox(
          height: MediaQuery.sizeOf(context).width * .16,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: paymentMethodsList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => paymentCubit.setActivePaymentMethod(index: index),
                child: PaymentMethodItem(
                  isActive: paymentCubit.activeMethodIndex == index,
                  paymentMethodModel: paymentMethodsList[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
