import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../Features/shop/presentation/view_models/shop cubit/shop_cubit.dart';
import '../functions/toast_message.dart';
import '../utils/cache_helper.dart';
import '../utils/consts.dart';

class SignOutListTile extends StatelessWidget {
  const SignOutListTile({
    super.key,
    required this.scaffoldContext,
  });
  final BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout_outlined),
      title: Text(
        'Sign out',
        style:
            Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13.5.sp),
      ),
      hoverColor: Colors.white70,
      onTap: () async {
        showDialog<String>(
          context: context,
          builder: (BuildContext contextDialog) => AlertDialog(
            elevation: 0,
            backgroundColor: ShopCubit.get(context).isDark
                ? scaffoldBackgroundColorDark
                : scaffoldBackgroundColorLight,
            title: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Are you sure ?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(contextDialog),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () {
                  CacheHelper.removeData(key: 'token');
                  toastMessage(
                      msg: 'Signed-out success', type: ToastType.success);
                  GoRouter.of(scaffoldContext).pushReplacement('/login');
                },
                child: Text('OK', style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        );
      },
    );
  }
}
