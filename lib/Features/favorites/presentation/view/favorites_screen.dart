import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/home/presentation/view_model/home%20cubit/home_cubit.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../core/widgets/empty_display_widget.dart';
import 'widgets/favorites_product_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.sizeOf(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context).favoriteModel?.data?.data;
        return ConditionalBuilder(
          condition: state is GetFavoriteSuccessState ||
              state is GetHomeDataSuccessState,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ConditionalBuilder(
              condition: cubit?.isNotEmpty ?? false,
              builder: (context) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit?.length ?? 0,
                  itemBuilder: (context, index) {
                    return FavoritesProductItem(
                      favoriteProduct: cubit?[index].product,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 15),
                );
              },
              fallback: (context) =>
                  const EmptyDisplayWidget(message: 'Favorites is Empty'),
            ),
          ),
          fallback: (BuildContext context) => const CustomLoadingIndicator(),
        );
      },
    );
  }
}