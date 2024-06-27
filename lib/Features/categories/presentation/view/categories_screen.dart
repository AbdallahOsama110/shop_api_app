import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../../home/presentation/view_model/home cubit/home_cubit.dart';
import 'widgets/categories_product_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.sizeOf(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context).categoryModel?.data?.data;
        return ConditionalBuilder(
          condition: state is! GetCategoryLoadingState && cubit != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: cubit?.length ?? 0,
              itemBuilder: (context, index) {
                return CategoriesProductItem(categoryModel: cubit?[index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 15),
            ),
          ),
          fallback: (BuildContext context) => const CustomLoadingIndicator(),
        );
      },
    );
  }
}
