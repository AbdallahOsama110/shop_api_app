import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/consts.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.banners,
  });
  final dynamic banners;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return CarouselSlider.builder(
      itemCount: banners?.length ?? 0,
      itemBuilder: (context, itemIndex, pageViewIndex) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: size.height * .15,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                banners?[itemIndex].image ?? nullImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
      options: CarouselOptions(
        height: size.height * .15,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
