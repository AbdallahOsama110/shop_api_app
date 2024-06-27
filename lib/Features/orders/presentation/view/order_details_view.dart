import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../view model/Orders cubit/orders_cubit.dart';
import 'widgets/order_details_widget.dart';
import 'widgets/order_products_listview.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          var ordersCubit = OrdersCubit.get(context).getOrderDetailsModel;
          return ConditionalBuilder(
            condition: state is! GetOrderDetailsLoading,
            fallback: (context) => const CustomLoadingIndicator(),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    OrderDetailsWidget(ordersCubit: ordersCubit),
                    const SizedBox(height: 20),
                    OrderProductsListView(ordersCubit: ordersCubit),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}