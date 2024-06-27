import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../../core/widgets/custom_network_image.dart';
import '../../../data/models/cart_model/cart_item.dart';

class CartProductImage extends StatelessWidget {
  const CartProductImage({super.key, required this.cartItem});
  final CartItem? cartItem;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: size.width * .3,
          color: Colors.white,
          child: AspectRatio(
            aspectRatio: 1 / .9,
            child: ConditionalBuilder(
              condition: cartItem?.product?.discount != 0,
              builder: (context) => Banner(
                message: 'Discount',
                textStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                location: BannerLocation.topEnd,
                child: CustomNetworkImage(
                    imageUrl: cartItem?.product?.image.toString() ?? nullImage),
              ),
              fallback: (context) => CustomNetworkImage(
                  imageUrl: cartItem?.product?.image.toString() ?? nullImage),
            ),
          ),
        ),
      ),
    );
  }
}
