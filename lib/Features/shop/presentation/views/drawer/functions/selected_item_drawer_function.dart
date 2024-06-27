import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void selectedItemDrawer(BuildContext context, int index) {
  switch (index) {
    case 0:
      GoRouter.of(context).push('/orders');
      break;
    case 1:
      GoRouter.of(context).push('/settings');
      break;
    case 2:
      GoRouter.of(context).push('/help');
      break;
    case 3:
      GoRouter.of(context).push('/information');
      break;
  }
}
