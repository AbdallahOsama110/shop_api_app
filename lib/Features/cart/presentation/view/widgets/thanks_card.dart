import 'package:flutter/material.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_button.dart';
import '../../view model/cart cubit/cart_cubit.dart';
import 'payment_item_info.dart';
import 'total_price_widget.dart';

class ThanksCard extends StatelessWidget {
  const ThanksCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: ShapeDecoration(
        color: ShopCubit.get(context).isDark ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: size.width * .165,
          left: size.width * .055,
          right: size.width * .055,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Your transaction was successful',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: size.width * .125),
            PaymentItemInfo(
              title: 'Date',
              value:
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            ),
            SizedBox(height: size.width * .02),
            PaymentItemInfo(
              title: 'Time',
              value:
                  '${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour > 12 ? 'PM' : 'AM'}',
            ),
            SizedBox(height: size.width * .02),
            SizedBox(height: size.width * .145),
            TotalPrice(
                title: 'Total', value: '\$${CartCubit.get(context).totalCost}'),
            SizedBox(height: size.width * .04),
            CustomButton(
              text: 'Back',
              onPressed: () {
                Navigator.of(context).pop();
                ShopCubit.get(context).changeNavIndex(0);
              },
            ),
            SizedBox(height: size.width * .08),
          ],
        ),
      ),
    );
  }
}
