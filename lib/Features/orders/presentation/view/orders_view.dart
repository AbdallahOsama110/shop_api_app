import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import '../../../../core/widgets/empty_display_widget.dart';
import '../view model/Orders cubit/orders_cubit.dart';
import 'widgets/orders_item_widget.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          var ordersCubit = OrdersCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetOrdersLoading,
            builder: (context) {
              return ConditionalBuilder(
                condition:
                    ordersCubit.getOrdersModel?.data?.data?.isNotEmpty ?? false,
                builder: (context) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        ordersCubit.getOrdersModel?.data?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return OrdersItemWidget(
                        index: index,
                        ordersCubit: ordersCubit,
                      );
                    },
                  );
                },
                fallback: (context) => const EmptyDisplayWidget(
                  message: 'Empty Orders List',
                ),
              );
            },
            fallback: (context) => const CustomLoadingIndicator(),
          );
        },
      ),
    );
  }
}
