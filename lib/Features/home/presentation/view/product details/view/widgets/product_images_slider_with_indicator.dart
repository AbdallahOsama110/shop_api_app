import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../../core/widgets/custom_network_image.dart';
import '../../../../../data/models/home_data_model/product_model.dart';
import '../../view model/cubit/product_cubit.dart';

class ProductImagesSliderWithIndicator extends StatelessWidget {
  const ProductImagesSliderWithIndicator({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    
    return BlocProvider(
        create: (context) => ProductCubit(),
        child: BlocBuilder<ProductCubit, ProductStates>(
          builder: (context, state) {
            var cubit = ProductCubit.get(context);
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: product.images.length,
                itemBuilder: (context, itemIndex, pageViewIndex) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: AspectRatio(
                      aspectRatio: 1 / .9,
                      child: CustomNetworkImage(
                          imageUrl: product.images[itemIndex].toString()),
                    ),
                  ),
                ),
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    cubit.activeIndicatorIndex(index);
                  },
                  height: size.height * .25,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  viewportFraction: .6,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedSmoothIndicator(
                activeIndex: cubit.activeIndex,
                count: product.images.length,
                effect: const WormEffect(
                    dotWidth: 13,
                    dotHeight: 13,
                    activeDotColor: Colors.lightGreen,
                    dotColor: Color.fromARGB(255, 195, 195, 195)),
              ),
            ],
          );
        },
      ),
    );
  }
}
