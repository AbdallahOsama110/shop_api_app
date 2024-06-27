import 'package:flutter/material.dart';
import '../../../../../data/models/home_data_model/product_model.dart';
import 'product_description.dart';
import 'product_details_like_button.dart';
import 'product_images_slider_with_indicator.dart';
import 'product_price_buy.dart';

class ProductScreenBody extends StatelessWidget {
  const ProductScreenBody({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 20),
            ProductImagesSliderWithIndicator(product: product),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductPriceAndBuyMethod(product: product),
                      ProductDetailsLikeButton(product: product),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProductDescription(product: product),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
