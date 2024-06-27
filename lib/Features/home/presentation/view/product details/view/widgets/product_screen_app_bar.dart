import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_api_app/core/widgets/custom_network_image.dart';
import '../../../../../data/models/home_data_model/product_model.dart';

AppBar productScreenAppBar(BuildContext context,
    {required ProductModel product}) {
  var size = MediaQuery.sizeOf(context);
  return AppBar(
    title: Row(
      children: [
        Hero(
          tag: "product-image+${product.id}",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 45,
              color: Colors.white,
              child: AspectRatio(
                aspectRatio: 1 / .9,
                child: CustomNetworkImage(imageUrl: product.image.toString()),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: size.width * .4,
          child: Text(
            product.name.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () => GoRouter.of(context).push('/cartScreen'),
        icon: const Icon(Icons.shopping_cart_outlined),
      ),
    ],
  );
}
