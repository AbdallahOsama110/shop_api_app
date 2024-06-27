import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/consts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../shop/presentation/view_models/shop cubit/shop_cubit.dart';
import '../../data/lists/onboarding_list.dart';
import '../view_models/Onboarding Cubit/onboarding_cubit.dart';
import 'widgets/custom_onboarding_item.dart';

class OnboardingScreen extends StatelessWidget {
  final pageController = PageController();

  OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var onboardingCubit = OnboardingCubit.get(context);
    var isDark = ShopCubit.get(context).isDark;

    return Scaffold(
      backgroundColor: isDark ? scaffoldBackgroundColorDark : Colors.white,
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: size.height * .8,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      onboardingCubit.onChangePageView(
                          index, onboardingList.length - 1);
                    },
                    controller: pageController,
                    allowImplicitScrolling: true,
                    itemCount: onboardingList.length,
                    itemBuilder: (context, index) => CustomOnboardingItem(
                      onboardingModel: onboardingList[index],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: state is OnboardingIsLast
                      ? CustomButton(
                          text: 'Get Started',
                          onPressed: () {
                            GoRouter.of(context).pushReplacement('/login');
                            CacheHelper.putData(
                                key: 'isFirstTimeOpen', value: false);
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                pageController.animateToPage(
                                  onboardingList.length - 1,
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                              child: Text(
                                'Skip',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                            SmoothPageIndicator(
                              effect: ExpandingDotsEffect(
                                dotColor: Colors.black26,
                                activeDotColor: isDark
                                    ? Colors.white
                                    : scaffoldBackgroundColorDark,
                                dotHeight: 10,
                                dotWidth: 10,
                                expansionFactor: 4,
                                spacing: 5,
                              ),
                              controller: pageController,
                              count: onboardingList.length,
                            ),
                            TextButton(
                              onPressed: () {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                              child: Text(
                                'Next',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
