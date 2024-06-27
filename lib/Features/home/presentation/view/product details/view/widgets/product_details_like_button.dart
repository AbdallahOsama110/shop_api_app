import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:like_button/like_button.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';
import '../../../../view_model/home cubit/home_cubit.dart';

class ProductDetailsLikeButton extends StatefulWidget {
  const ProductDetailsLikeButton({
    super.key,
    required this.product,
    this.isFromHome = false,
  });
  final dynamic product;
  final bool isFromHome;

  @override
  State<ProductDetailsLikeButton> createState() =>
      _ProductDetailsLikeButtonState();
}

class _ProductDetailsLikeButtonState extends State<ProductDetailsLikeButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? const Offset(0.5, 2) : const Offset(5, 3);
    double blur = isPressed ? 1 : 5;
    return Listener(
      onPointerDown: (_) => setState(() => isPressed = true),
      onPointerUp: (_) {
        setState(() {
          isPressed = false;
        });
        HomeCubit.get(context).changeFav(widget.product.id!);
      },
      /*  */
      child: AnimatedContainer(
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 100),
        height: 40,
        width: 40,
        padding: const EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (ShopCubit.get(context).isDark)
              BoxShadow(
                color: const Color.fromARGB(255, 24, 25, 28),
                offset: distance,
                blurRadius: blur,
                spreadRadius: 0.0,
                inset: isPressed,
              ),
            if (ShopCubit.get(context).isDark)
              BoxShadow(
                color: const Color.fromARGB(255, 43, 47, 52),
                offset: -distance,
                blurRadius: blur,
                spreadRadius: 0.0,
                inset: isPressed,
              ),
            if (!ShopCubit.get(context).isDark)
              BoxShadow(
                color: const Color(0xFFA7A9AF),
                offset: distance,
                blurRadius: blur,
                spreadRadius: 0.0,
                inset: isPressed,
              ),
            if (!ShopCubit.get(context).isDark)
              BoxShadow(
                color: Colors.white,
                offset: -distance,
                blurRadius: blur,
                spreadRadius: 0.0,
                inset: isPressed,
              ),
          ],
        ),
        child: LikeButton(
          bubblesColor: const BubblesColor(
              dotPrimaryColor: Color.fromARGB(255, 101, 189, 0),
              dotSecondaryColor: Color.fromARGB(255, 219, 193, 0)),
          likeBuilder: (isLiked) {
            return HomeCubit.get(context).favorites[widget.product.id] == true
                ? Icon(
                    Icons.favorite_rounded,
                    size: isPressed ? 20 : 25,
                    color: Colors.lightGreen,
                  )
                : Icon(
                    Icons.favorite_outline_rounded,
                    size: isPressed ? 20 : 25,
                    color: Colors.lightGreen,
                  );
          },
        ),
      ),
    );
  }
}
