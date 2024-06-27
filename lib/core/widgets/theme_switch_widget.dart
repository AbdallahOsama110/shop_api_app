import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';

Widget imageSwitch() {
  return BlocConsumer<ShopCubit, ShopStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return Transform.scale(
        scale: 0.9,
        child: Switch(
          //trackColor: MaterialStateProperty.all(Colors.black38),
          trackOutlineColor: MaterialStateProperty.all(Colors.white),
          inactiveTrackColor: const Color(0xffC7E8FF),
          activeTrackColor: const Color(0xff142766),
          activeColor: Colors.green.withOpacity(0.4),
          inactiveThumbColor: Colors.blue.withOpacity(0.4),
          // when the switch is on, this image will be displayed
          activeThumbImage: const AssetImage('assets/images/half-moon.png'),
          // when the switch is off, this image will be displayed
          inactiveThumbImage: const AssetImage('assets/images/summer.png'),
          value: ShopCubit.get(context).isDark,

          onChanged: (value) => ShopCubit.get(context).changeTheme(value),
        ),
      );
    },
  );
}