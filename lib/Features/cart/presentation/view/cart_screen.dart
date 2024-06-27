import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/cart/presentation/view%20model/cart%20cubit/cart_cubit.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../core/widgets/empty_display_widget.dart';
import 'widgets/cart_item_widget.dart';
import 'widgets/cart_checkout_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    CartCubit.get(context).getCartItem();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cartCubit = CartCubit.get(context);
        var size = MediaQuery.sizeOf(context);
        return ConditionalBuilder(
          condition: state is! GetCartLoadingState &&
              cartCubit.cartModel != null &&
              state is! AddOrRemoveCartItemLoadingState,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ConditionalBuilder(
              condition:
                  cartCubit.cartModel?.data?.cartItems?.isNotEmpty ?? false,
              builder: (context) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          cartCubit.cartModel?.data?.cartItems?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cartItem:
                              cartCubit.cartModel?.data?.cartItems?[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 15),
                    ),
                    CartChechOutAndCostWidget(cartCubit: cartCubit, size: size)
                  ],
                );
              },
              fallback: (BuildContext context) {
                return const EmptyDisplayWidget(message: 'Cart is Empty');
              },
            ),
          ),
          fallback: (BuildContext context) => const CustomLoadingIndicator(),
        );
      },
    );
  }
}
