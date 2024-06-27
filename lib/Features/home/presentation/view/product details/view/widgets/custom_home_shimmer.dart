import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomHomeShimmer extends StatelessWidget {
  const CustomHomeShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: size.width,
          height: size.height * .15,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: size.width * .2,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 10 : 0,
                    right: index == 4 ? 10 : 0,
                  ),
                  height: size.width * .2,
                  width: size.width * .25,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1.4,
            children: List.generate(
              6,
              (index) => SizedBox(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
