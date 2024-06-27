import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../functions/toast_message.dart';
import '../utils/cache_helper.dart';
import '../utils/consts.dart';

class LogoutIconButton extends StatelessWidget {
  const LogoutIconButton({super.key, required this.scaffoldContext});
  final BuildContext scaffoldContext;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        showDialog<String>(
          context: context,
          builder: (BuildContext contextDialog) => AlertDialog(
            elevation: 0,
            backgroundColor: scaffoldBackgroundColorDark,
            title: const Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Are you sure ?',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(contextDialog),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  CacheHelper.removeData(key: 'token');
                  toastMessage(
                      msg: 'Signed-out success', type: ToastType.success);
                  GoRouter.of(scaffoldContext).pushReplacement('/login');
                },
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
      icon: const Icon(
        Icons.logout_outlined,
        //color: Colors.white,
      ),
    );
  }
}
