import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cart/presentation/view model/cart cubit/cart_cubit.dart';
import '../../view_model/home cubit/home_cubit.dart';

class LikeAndAddItemIcon extends StatelessWidget {
  const LikeAndAddItemIcon({
    super.key,
    required this.product,
    this.inFav = false,
  });
  final bool inFav;
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!inFav)
          BlocBuilder<CartCubit, CartStates>(
            builder: (context, state) {
              return SizedBox(
                width: 25,
                height: 25,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await CartCubit.get(context)
                        .addAndRemoveCartItem(productId: product!.id!);
                    //HomeCubit.get(context).getHomeDataForCart();
                  },
                  icon: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: CartCubit.get(context).cart[product.id] == true
                        ? Colors.lightGreen
                        : Colors.grey,
                  ),
                ),
              );
            },
          ),
        const SizedBox(width: 5),
        SizedBox(
          width: 25,
          height: 25,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              HomeCubit.get(context).changeFav(product.id!);
            },
            icon: Icon(
              Icons.favorite_rounded,
              color: HomeCubit.get(context).favorites[product.id] == true
                  ? Colors.lightGreen
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
