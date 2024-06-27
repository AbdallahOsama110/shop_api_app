import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key, required this.title, required this.value});

  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}
