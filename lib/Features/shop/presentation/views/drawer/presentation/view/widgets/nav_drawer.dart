import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../../core/utils/consts.dart';
import '../../../../../../../../core/widgets/sign_out_list_tile.dart';
import '../../../functions/selected_item_drawer_function.dart';
import 'menu_item_widget.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({super.key, required this.isdark});
  final bool isdark;
  final List<dynamic> selectedList = [];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isdark ? darktDrawerColor : lightDrawerColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Spacer(flex: 1),
              SizedBox(
                width: 100,
                height: 50,
                child: InkWell(
                  onTap: () => ZoomDrawer.of(context)!.close(),
                  borderRadius: BorderRadius.circular(30),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new_rounded),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Back',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 13.5.sp),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              buildMenuItem(
                context,
                text: 'Orders',
                icon: Icons.local_mall_outlined,
                onClicked: () => selectedItemDrawer(context, 0),
              ),
              const SizedBox(height: 10),
              buildMenuItem(
                context,
                text: 'Settings',
                icon: Icons.settings_outlined,
                onClicked: () => selectedItemDrawer(context, 1),
              ),
              const SizedBox(height: 10),
              buildMenuItem(
                context,
                text: 'Help',
                icon: Icons.help_outline,
                onClicked: () => selectedItemDrawer(context, 2),
              ),
              const SizedBox(height: 10),
              buildMenuItem(
                context,
                text: 'Information',
                icon: Icons.info_outline,
                onClicked: () => selectedItemDrawer(context, 3),
              ),
              const SizedBox(height: 10),
              SignOutListTile(scaffoldContext: context),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
