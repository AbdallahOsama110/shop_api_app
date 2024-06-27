import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';
import 'package:shop_api_app/core/utils/consts.dart';
import 'animated_fade_widget.dart';
import 'animated_slide_widget.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key, required this.nextScreen});
  final String nextScreen;

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController fadeAnimationController;
  late AnimationController vAnimationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> vSlideAnimation;

  @override
  void initState() {
    super.initState();
    initFadeAnimation();
    initVSlidingAnimation();
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() {
    Future.delayed(const Duration(seconds: 5),
        () => GoRouter.of(context).pushReplacement(widget.nextScreen));
  }

  void initVSlidingAnimation() {
    vAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    vSlideAnimation = Tween<Offset>(begin: const Offset(0, 3), end: Offset.zero)
        .animate(vAnimationController);
    vAnimationController.forward();
  }

  void initFadeAnimation() {
    fadeAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    fadeAnimation =
        CurvedAnimation(parent: fadeAnimationController, curve: Curves.ease);
    fadeAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    fadeAnimationController.dispose();
    vAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedFadeWidget(
          animation: fadeAnimation,
          widget: Icon(
            FontAwesomeIcons.placeOfWorship,
            size: 60,
            color: ShopCubit.get(context).isDark
                ? Colors.white
                : scaffoldBackgroundColorDark,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedSlideWidget(
          animation: vSlideAnimation,
          widget: Text(
            'Lets Shopping',
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
