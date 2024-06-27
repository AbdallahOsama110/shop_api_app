import 'package:flutter/material.dart';
import '../../../data/models/get_order_details_model/get_order_details_model.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.ordersCubit,
  });

  final GetOrderDetailsModel? ordersCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Number: ${ordersCubit?.data?.id}'),
        const SizedBox(height: 5),
        Text('Status: ${ordersCubit?.data?.status}'),
        const SizedBox(height: 5),
        Text('Order At: ${ordersCubit?.data?.date}'),
        const SizedBox(height: 5),
        Text('Payment: ${ordersCubit?.data?.paymentMethod}'),
        const SizedBox(height: 5),
        Text('Cost: ${ordersCubit?.data?.cost} LE'),
      ],
    );
  }
}
