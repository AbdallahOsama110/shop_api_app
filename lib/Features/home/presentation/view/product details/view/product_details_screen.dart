import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/cart/presentation/view%20model/cart%20cubit/cart_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import '../../../../../../core/widgets/custom_button.dart';
import 'widgets/product_screen_app_bar.dart';
import 'widgets/product_screen_body.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final dynamic product;
  @override
  Widget build(BuildContext context) {
    if (product != null) {
      return Scaffold(
        appBar: productScreenAppBar(context, product: product!),
        body: ProductScreenBody(product: product!),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          child: BlocBuilder<CartCubit, CartStates>(
            builder: (context, state) {
              return CustomButton(
                text: CartCubit.get(context).cart[product.id] == true
                    ? 'remove from cart'
                    : 'add to cart',
                
                overlayColor: Colors.greenAccent,
                onPressed: () {
                  CartCubit.get(context)
                      .addAndRemoveCartItem(productId: product!.id!);
                },
              );
            },
          ),
        ),
      );
    }
    return const Scaffold(
      body: CustomLoadingIndicator(),
    );
  }
}
