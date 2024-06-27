import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_api_app/Features/cart/data/models/payment_method_model/payment_method_model.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.isActive,
    required this.paymentMethodModel,
  });
  final bool isActive;
  final PaymentMethodModel paymentMethodModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size.width * .25,
      height: size.width * .125,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.50,
            color: isActive ? const Color(0xFF34A853) : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: 0,
            color: isActive
                ? const Color(0xFF34A853)
                : Theme.of(context).scaffoldBackgroundColor,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Center(
          child: paymentMethodModel.paymentMethod != '1'
              ? SvgPicture.asset(paymentMethodModel.methodImage)
              : Image.asset(paymentMethodModel.methodImage),
        ),
      ),
    );
  }
}
