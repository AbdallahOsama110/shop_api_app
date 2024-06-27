import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/widgets/custom_network_image.dart';
import '../../../../../data/models/home_data_model/product_model.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget(
      {super.key, required this.product, this.containerHeight});
  final ProductModel product;
  final double? containerHeight;
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.sizeOf(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: containerHeight,
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 1 / .9,
          child: ConditionalBuilder(
            condition: product.discount != 0,
            builder: (context) => Banner(
              message: 'Discount',
              textStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              location: BannerLocation.topEnd,
              child: CustomNetworkImage(imageUrl: product.image.toString()),
            ),
            fallback: (context) =>
                CustomNetworkImage(imageUrl: product.image.toString()),
          ),
        ),
      ),
    );
  }
}