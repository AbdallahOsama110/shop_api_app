import 'package:flutter/material.dart';
import 'widgets/thanks_view_body.dart';

class ThanksView extends StatelessWidget {
  const ThanksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(child: ThanksViewBody()),
      ),
    );
  }
}
