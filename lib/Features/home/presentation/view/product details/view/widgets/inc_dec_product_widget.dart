import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/cart/presentation/view%20model/cart%20cubit/cart_cubit.dart';
import '../../../../../../cart/data/models/cart_model/cart_item.dart';

class IncreaseAndDecreaseProductWidget extends StatelessWidget {
  const IncreaseAndDecreaseProductWidget({
    super.key,
    required this.cartItem,
  });
  final CartItem? cartItem;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //var cartCubit = CartCubit.get(context);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (cartItem?.quantity != 1) {
                  CartCubit.get(context).updateCart(
                    id: cartItem?.id ?? 0,
                    quantity: cartItem!.quantity = cartItem!.quantity! - 1,
                  );
                } else {
                  CartCubit.get(context).addAndRemoveCartItem(
                      productId: cartItem!.product?.id ?? 0);
                }
              },
              icon: Icon(Icons.remove, size: size.width * .059),
            ),
            Container(
              height: size.width * .097,
              width: size.width * .097,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              child: Text(
                '${cartItem!.quantity}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            IconButton(
              onPressed: () {
                CartCubit.get(context).updateCart(
                  id: cartItem!.id ?? 0,
                  quantity: cartItem!.quantity = cartItem!.quantity! + 1,
                );
              },
              icon: Icon(Icons.add, size: size.width * .059),
            ),
          ],
        );
      },
    );
  }
}
