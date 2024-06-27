import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_dashed_line_widget.dart';

class CheckoutDividerWidget extends StatelessWidget {
  const CheckoutDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: CustomDashedLine(),
        ),
        Positioned(
          left: -32,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            radius: 17,
          ),
        ),
        Positioned(
          right: -32,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            radius: 17,
          ),
        ),
      ],
    );
  }
}
