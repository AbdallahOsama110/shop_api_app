import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import '../../Features/auth/presentation/view_model/auth%20cubit/auth_cubit.dart';
import '../utils/consts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.padding = EdgeInsets.zero,
    this.color = const Color.fromARGB(255, 67, 160, 71),
    this.overlayColor = Colors.purple,
    this.width,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color overlayColor;
  final double? width;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(overlayColor.withOpacity(.3)),
          elevation: const WidgetStatePropertyAll(0),
          fixedSize: WidgetStateProperty.all(
              Size(width ?? size.width / 1.25, size.width / 8)),
          backgroundColor: WidgetStateProperty.all(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide.none,
            ),
          ),
        ),
        child: ConditionalBuilder(
            condition: isLoading,
            builder: (context) =>
                const CustomLoadingIndicator(color: Colors.white),
            fallback: (context) {
              return Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
      ),
    );
  }
}

class CustomAnimatedButton extends StatelessWidget {
  const CustomAnimatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.padding = EdgeInsets.zero,
    this.isSignUp = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var authCubit = AuthCubit.get(context);

    return Padding(
      padding: padding,
      child: ProgressButton(
        height: size.width / 8,
        maxWidth: size.width / 1.25,
        progressIndicatorAlignment: MainAxisAlignment.spaceAround,
        //minWidth: size.width / 1.5,
        radius: 20,
        stateWidgets: {
          ButtonState.idle:
              Text(text, style: Theme.of(context).textTheme.titleLarge),
          ButtonState.loading: const Text("Loading", style: Styles.textStyle20),
          ButtonState.fail: const Text("Fail", style: Styles.textStyle20),
          ButtonState.success: const Text("Success", style: Styles.textStyle20),
        },
        stateColors: {
          ButtonState.idle: Colors.white.withOpacity(.15),
          ButtonState.loading: Colors.purple.shade300,
          ButtonState.fail: Colors.red.shade300,
          ButtonState.success: Colors.green.shade400,
        },
        onPressed: onPressed,
        onAnimationEnd:
            (AnimationStatus animationStatus, ButtonState currentState) async {
          if (currentState == ButtonState.fail) {
            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              isSignUp
                  ? authCubit.sigUpButtonState
                  : authCubit.logInButtonState = ButtonState.idle;
            }
          }
        },
        state:
            isSignUp ? authCubit.sigUpButtonState : authCubit.logInButtonState,
      ),
    );
  }
}
