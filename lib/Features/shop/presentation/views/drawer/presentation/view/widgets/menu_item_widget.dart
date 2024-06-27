import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildMenuItem(
  BuildContext context, {
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  const hoverColor = Colors.white70;
  return ListTile(
    leading: Icon(icon),
    title: Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
    ),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
