import 'package:flutter/material.dart';
import '../../../data/models/get_order_details_model/get_order_details_model.dart';
import 'order_item.dart';

class OrderProductsListView extends StatelessWidget {
  const OrderProductsListView({
    super.key,
    required this.ordersCubit,
  });
  final GetOrderDetailsModel? ordersCubit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Products:'),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: ordersCubit?.data?.products?.length ?? 0,
              itemBuilder: (context, index) {
                return OrderItem(ordersCubit: ordersCubit, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}