import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArrowBackIconButton extends StatelessWidget {
  const ArrowBackIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () => GoRouter.of(context).pop(),
        borderRadius: BorderRadius.circular(15),
        child: Icon(
          Icons.arrow_back_rounded,
          size: MediaQuery.sizeOf(context).width * .07,
        ),
      ),
    );
  }
}
