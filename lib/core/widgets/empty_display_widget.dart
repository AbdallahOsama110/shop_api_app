import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyDisplayWidget extends StatelessWidget {
  const EmptyDisplayWidget({
    super.key,
    this.message,
    this.image = 'assets/images/emptyAnimation1.json',
  });
  final String? message;
  final String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Text(
            message ?? '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(flex: 1),
          Lottie.asset(image),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
