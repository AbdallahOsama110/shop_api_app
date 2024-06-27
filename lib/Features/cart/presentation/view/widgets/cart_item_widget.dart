import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../home/presentation/view/product details/view/widgets/inc_dec_product_widget.dart';
import '../../../data/models/cart_model/cart_item.dart';
import '../../view model/cart cubit/cart_cubit.dart';
import 'cart_product_image.dart';
import 'cart_product_price.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });
  final CartItem? cartItem;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: size.width * .36,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CartProductImage(cartItem: cartItem),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * .4,
                      child: Text(
                        cartItem?.product?.name.toString() ?? 'Name',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        CartCubit.get(context).addAndRemoveCartItem(
                            productId: cartItem?.product?.id ?? 0);
                      },
                      icon: Icon(
                        FontAwesomeIcons.solidTrashCan,
                        size: size.width * .0435,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CartProductPrice(cartItem: cartItem),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Spacer(flex: 2),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IncreaseAndDecreaseProductWidget(
                                cartItem: cartItem!,
                              ),
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
