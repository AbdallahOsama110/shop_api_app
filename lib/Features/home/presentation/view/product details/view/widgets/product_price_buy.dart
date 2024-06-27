import 'package:flutter/material.dart';
import '../../../../../data/models/home_data_model/product_model.dart';

class ProductPriceAndBuyMethod extends StatelessWidget {
  const ProductPriceAndBuyMethod({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.discount != 0)
              Text(
                '- ${product.discount}% ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 20, color: Colors.red),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            Text(
              'EGP',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontSize: 14, color: Colors.green),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${product.price ?? ''}  ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        if (product.discount != 0)
          Row(
            children: [
              Text(
                'Old Price: ',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EGP',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${product.oldPrice ?? ''}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14,
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
    );
  }
}
