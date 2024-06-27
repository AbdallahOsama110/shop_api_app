import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_network_image.dart';
import '../../../data/models/get_order_details_model/get_order_details_model.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.ordersCubit,
    required this.index,
  });
  final GetOrderDetailsModel? ordersCubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1 / .9,
          child: CustomNetworkImage(
            imageUrl: '${ordersCubit?.data?.products?[index].image}',
          ),
        ),
        title: Text(
          '${ordersCubit?.data?.products?[index].name}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity: ${ordersCubit?.data?.products?[index].quantity}',
              ),
              Text(
                '${ordersCubit?.data?.products?[index].price} LE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
