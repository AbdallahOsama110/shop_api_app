import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_api_app/Features/cart/presentation/view/cart_screen.dart';
import 'package:shop_api_app/core/utils/consts.dart';
import '../../../categories/presentation/view/categories_screen.dart';
import '../../../favorites/presentation/view/favorites_screen.dart';
import '../../../home/presentation/view/home_screen.dart';
import '../view_models/shop%20cubit/shop_cubit.dart';
import 'widgets/buttom_nav_bar.dart';
import 'package:flutter_svg/svg.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: IconButton(
              icon: SizedBox(
                  height: 30,
                  child: SvgPicture.asset(
                    'assets/images/menu_icon.svg',
                    color: ShopCubit.get(context).isDark
                        ? Colors.white
                        : scaffoldBackgroundColorDark,
                  )),
              onPressed: () {
                FocusScope.of(context).unfocus();
                ZoomDrawer.of(context)!.toggle();
              },
            ),
            title: const Text('Shopee'),
            actions: [
              IconButton(
                onPressed: () => GoRouter.of(context).push('/search'),
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                ),
              ),
            ],
          ),
          body: IndexedStack(
            index: ShopCubit.get(context).currNavIndex,
            children: const [
              HomeScreen(),
              CategoriesScreen(),
              FavoritesScreen(),
              CartScreen(),
            ],
          ),
          bottomNavigationBar: const CustomButtomNavBar(),
        );
      },
    );
  }
}
