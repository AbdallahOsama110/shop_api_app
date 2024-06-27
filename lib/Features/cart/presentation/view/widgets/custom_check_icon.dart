import 'package:flutter/material.dart';
import '../../../../shop/presentation/view_models/shop cubit/shop_cubit.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CircleAvatar(
      radius: size.width * .125,
      backgroundColor:
          ShopCubit.get(context).isDark ? Colors.black : Colors.white,
      child: CircleAvatar(
        radius: size.width * .1,
        backgroundColor: Colors.green,
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: size.width * .125,
        ),
      ),
    );
  }
}
