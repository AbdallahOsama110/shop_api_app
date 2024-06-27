import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../shop/presentation/view_models/shop cubit/shop_cubit.dart';
import '../../view_model/auth%20cubit/auth_cubit.dart';
import '../../view_model/auth%20cubit/auth_states.dart';
import 'auth_title.dart';
import 'text_field_pro.dart';

class SignUpCard extends StatelessWidget {
  const SignUpCard({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  Widget build(BuildContext context) {
    var authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) async {
        authCubit.sigUpButtonState = state is SignUpLoading
            ? ButtonState.loading
            : state is SignUpSuccess
                ? ButtonState.success
                : state is SignUpError
                    ? ButtonState.fail
                    : ButtonState.idle;
        if (authCubit.sigUpButtonState == ButtonState.fail ||
            authCubit.sigUpButtonState == ButtonState.success) {
          await Future.delayed(const Duration(milliseconds: 1500));
          authCubit.sigUpButtonState = ButtonState.idle;
        }

        if (state is SignUpSuccess) {
          await Future.delayed(const Duration(milliseconds: 1500));
          authCubit.changePageIndex();
          if (authCubit.currPageIndex == 1) {
            authCubit.pageController.previousPage(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastLinearToSlowEaseIn,
            );
          }
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
                  key: authCubit.signUpFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthTitle(size: size, title: 'SIGN UP'),
                      CustomTextFormFieldPro(
                        controller: authCubit.userNameController,
                        hintText: 'UserName...',
                      ),
                      CustomTextFormFieldPro(
                        controller: authCubit.phoneController,
                        hintText: 'Phone...',
                        isPhone: true,
                      ),
                      CustomTextFormFieldPro(
                        controller: authCubit.emailUpController,
                        hintText: 'Email...',
                        isEmail: true,
                      ),
                      CustomTextFormFieldPro(
                        controller: authCubit.passwordUpController,
                        hintText: 'Password...',
                        isPassword: true,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Back to sign-in',
                            style: Theme.of(context).textTheme.bodySmall,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                HapticFeedback.lightImpact();
                                authCubit.changePageIndex();
                                if (authCubit.currPageIndex == 1) {
                                  authCubit.pageController.previousPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                }
                              },
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * .1),
                      CustomAnimatedButton(
                        text: 'Sing-Up',
                        isSignUp: true,
                        padding: EdgeInsets.only(bottom: size.width * .05),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          if (authCubit.signUpFormKey.currentState
                                  ?.validate() ==
                              true) {
                            AuthCubit.get(context).userSignUp();
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
