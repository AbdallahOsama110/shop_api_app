import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.color = Colors.green});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
