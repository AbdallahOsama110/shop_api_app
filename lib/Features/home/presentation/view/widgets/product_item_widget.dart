import 'package:flutter/material.dart';
import '../../../../../core/widgets/price_widget.dart';
import '../../../data/models/home_data_model/product_model.dart';
import '../product details/view/product_details_screen.dart';
import '../product details/view/widgets/product_image_widget.dart';
import 'like_and_add_item_icon.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ProductDetailsScreen(product: product)));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "product-image+${product.id}",
                  child: ProductImageWidget(product: product),
                ),
                const SizedBox(height: 5),
                Text(
                  product.name ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                PriceWidget(
                  price: product.price.toDouble(),
                  color: Colors.green,
                ),
                if (product.discount != 0)
                  Row(
                    children: [
                      Text(
                        '- ${product.discount}% ',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.red.shade400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EGP',
                            style: Theme.of(context).textTheme.labelSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${product.oldPrice ?? ''}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: LikeAndAddItemIcon(product: product),
          ),
        ],
      ),
    );
  }
}
