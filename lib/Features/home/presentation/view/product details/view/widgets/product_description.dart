import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../data/models/home_data_model/product_model.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ReadMoreText(
          product.description.toString(),
          trimLines: 5,
          colorClickableText: Colors.green,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          moreStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
          lessStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
        ),
      ],
    );
  }
}
