import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view model/Orders cubit/orders_cubit.dart';
import '../order_details_view.dart';

class OrdersItemWidget extends StatelessWidget {
  const OrdersItemWidget({
    super.key,
    required this.ordersCubit,
    required this.index,
  });
  final OrdersCubit ordersCubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    var id = ordersCubit.getOrdersModel?.data?.data?[index].id;
    var status = ordersCubit.getOrdersModel?.data?.data?[index].status;
    var date = ordersCubit.getOrdersModel?.data?.data?[index].date;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) =>
                    OrdersCubit()..getOrderDetails(id: id ?? 0),
                child: const OrderDetailsView(),
              ))),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Number: $id'),
            const SizedBox(height: 5),
            Text('Status: $status'),
            const SizedBox(height: 5),
            Text('Order At: $date'),
          ],
        ),
      ),
    );
  }
}
