import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    this.color,
  });

  final dynamic price;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EGP',
          style:
              Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '$price',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
