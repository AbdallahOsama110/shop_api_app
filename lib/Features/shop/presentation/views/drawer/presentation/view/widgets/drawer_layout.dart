import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';
import 'package:shop_api_app/Features/shop/presentation/views/shop_layout.dart';
import '../../../../../../../../core/utils/consts.dart';
import 'nav_drawer.dart';

class DrawerLayout extends StatelessWidget {
  const DrawerLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ZoomDrawer(
          style: DrawerStyle.defaultStyle,
          borderRadius: 25,
          mainScreenTapClose: true,
          androidCloseOnBackTap: true,
          showShadow: true,
          shadowLayer2Color: ShopCubit.get(context).isDark
              ? darkshadowDrawerColor2
              : lightshadowDrawerColor2,
          menuBackgroundColor: ShopCubit.get(context).isDark
              ? darktDrawerColor
              : lightDrawerColor,
          moveMenuScreen: true,
          mainScreen: const ShopLayout(),
          menuScreen:
              NavigationDrawerWidget(isdark: ShopCubit.get(context).isDark),
        );
      },
    );
  }
}
