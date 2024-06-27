import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../view_models/shop cubit/shop_cubit.dart';

class CustomButtomNavBar extends StatelessWidget {
  const CustomButtomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    var size = MediaQuery.sizeOf(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //var isDark = ShopCubit.get(context).isDark;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            //border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
            borderRadius: BorderRadius.circular(50),
          ),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            tabBorderRadius: 50,
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 1,
            //activeColor: cubit.isDark ? Colors.white : Colors.deepPurple,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            //duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey.shade900,
            //color: cubit.isDark ? Colors.white : Colors.black54,
            //tabBackgroundColor: Colors.grey.shade900,
            color: Colors.white,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
                textStyle: TextStyle(
                  fontSize: size.width * .028,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.category_outlined,
                text: 'Category',
                textStyle: TextStyle(
                  fontSize: size.width * .028,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.favorite_outline_rounded,
                text: 'Favorite',
                textStyle: TextStyle(
                  fontSize: size.width * .028,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.shopping_bag_outlined,
                text: 'Cart',
                textStyle: TextStyle(
                  fontSize: size.width * .028,
                  color: Colors.white,
                ),
              ),
            ],
            selectedIndex: cubit.currNavIndex,
            onTabChange: (index) => cubit.changeNavIndex(index),
          ),
        );
      },
    );
  }
}
