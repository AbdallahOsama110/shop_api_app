import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../shop/presentation/view_models/shop cubit/shop_cubit.dart';
import '../../view_model/auth cubit/auth_cubit.dart';
import '../../view_model/auth%20cubit/auth_states.dart';
import 'auth_title.dart';
import 'text_field_pro.dart';

class LogInCard extends StatelessWidget {
  const LogInCard({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  Widget build(BuildContext context) {
    var authCubit = AuthCubit.get(context);

    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) async {
        authCubit.logInButtonState = state is LoginLoading
            ? ButtonState.loading
            : state is LoginSuccess
                ? ButtonState.success
                : state is LoginError
                    ? ButtonState.fail
                    : ButtonState.idle;

        if (state is LoginSuccess) {
          await Future.delayed(const Duration(milliseconds: 1500));
          if (context.mounted) GoRouter.of(context).pushReplacement('/home');
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Container(
                width: size.width * .9,
                color: ShopCubit.get(context).isDark
                    ? Colors.white.withOpacity(.05)
                    : Colors.grey.withOpacity(.15),
                child: Form(
                  key: authCubit.logInFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthTitle(size: size, title: 'SIGN IN'),
                      CustomTextFormFieldPro(
                        controller: authCubit.emailcontroller,
                        hintText: 'Email...',
                        isEmail: true,
                      ),
                      CustomTextFormFieldPro(
                        controller: authCubit.passwordcontroller,
                        hintText: 'Password...',
                        isPassword: true,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Create a new Account',
                            style: Theme.of(context).textTheme.bodySmall,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                HapticFeedback.lightImpact();
                                authCubit.changePageIndex();
                                if (authCubit.currPageIndex == 0) {
                                  authCubit.pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                }
                              },
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * .3),
                      CustomAnimatedButton(
                        text: 'Sing-In',
                        padding: EdgeInsets.only(bottom: size.width * .05),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          if (authCubit.logInFormKey.currentState?.validate() ==
                              true) {
                            AuthCubit.get(context).userLogin();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
