import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.width * .15,
        bottom: size.width * .1,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
