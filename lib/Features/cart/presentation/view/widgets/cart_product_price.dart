import 'package:flutter/material.dart';
import '../../../data/models/cart_model/cart_item.dart';

class CartProductPrice extends StatelessWidget {
  const CartProductPrice({
    super.key,
    required this.cartItem,
  });

  final CartItem? cartItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EGP',
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${cartItem?.product?.price ?? ''}  ',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        if (cartItem?.product?.discount != 0)
          Row(
            children: [
              Text(
                '- ${cartItem?.product?.discount}% ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.red.shade400),
                maxLines: 1,
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
                        .labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${cartItem?.product?.oldPrice ?? ''}',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(
                          decoration:
                              TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                        ),
                    maxLines: 1,
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
