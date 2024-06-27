import 'package:flutter/material.dart';
import '../../../data/models/onboarding_model.dart';

class CustomOnboardingItem extends StatelessWidget {
  const CustomOnboardingItem({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          onboardingModel.image,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                onboardingModel.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              Text(
                onboardingModel.bodyText,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
