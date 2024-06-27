import 'package:flutter/material.dart';
import '../../view_model/auth%20cubit/auth_cubit.dart';
import 'login_card.dart';
import 'sign_up_card.dart';

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({
    super.key,
    required this.size,
  });
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Expanded(
              flex: 5,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: AuthCubit.get(context).pageController,
                onPageChanged: (index) {
                  AuthCubit.get(context).currPageIndex = index;
                  AuthCubit.get(context).changePageIndex();
                },
                children: [
                  LogInCard(size: size),
                  SignUpCard(size: size),
                ],
              )),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
