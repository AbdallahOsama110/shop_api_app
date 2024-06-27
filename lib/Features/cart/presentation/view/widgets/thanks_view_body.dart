import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_dashed_line_widget.dart';
import 'custom_check_icon.dart';
import 'thanks_card.dart';

class ThanksViewBody extends StatelessWidget {
  const ThanksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .05,
        vertical: size.width * .2,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const ThanksCard(),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .17 + 20,
            left: 20 + 8,
            right: 20 + 8,
            child: const CustomDashedLine(),
          ),
          Positioned(
            left: -20,
            bottom: MediaQuery.sizeOf(context).height * .17,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Positioned(
            right: -20,
            bottom: MediaQuery.sizeOf(context).height * .17,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CustomCheckIcon(),
          ),
        ],
      ),
    );
  }
}
